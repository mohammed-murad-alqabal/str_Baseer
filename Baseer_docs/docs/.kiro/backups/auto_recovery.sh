#!/bin/bash

# 🔄 نص الاستعادة التلقائية للفحص الشامل
# Auto Recovery Script for Comprehensive Project Scanning

set -e  # توقف عند أي خطأ

# ألوان للمخرجات
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# مسارات الملفات
BACKUP_DIR=".kiro/backups"
LATEST_STATE="$BACKUP_DIR/scan_state_latest.json"
PROJECT_PROGRESS="$BACKUP_DIR/project_progress.json"
FILE_INVENTORY="$BACKUP_DIR/file_inventory.json"
RECOVERY_LOG="$BACKUP_DIR/recovery.log"

# دالة الطباعة الملونة
print_status() {
    echo -e "${BLUE}[$(date '+%Y-%m-%d %H:%M:%S')]${NC} $1"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# دالة فحص وجود الملفات
check_backup_files() {
    print_status "فحص ملفات النسخ الاحتياطي..."
    
    if [[ ! -d "$BACKUP_DIR" ]]; then
        print_error "مجلد النسخ الاحتياطي غير موجود: $BACKUP_DIR"
        return 1
    fi
    
    local files_exist=true
    
    if [[ ! -f "$LATEST_STATE" ]]; then
        print_warning "ملف الحالة الأخيرة غير موجود: $LATEST_STATE"
        files_exist=false
    fi
    
    if [[ ! -f "$PROJECT_PROGRESS" ]]; then
        print_warning "ملف تقدم المشاريع غير موجود: $PROJECT_PROGRESS"
        files_exist=false
    fi
    
    if [[ ! -f "$FILE_INVENTORY" ]]; then
        print_warning "ملف جرد الملفات غير موجود: $FILE_INVENTORY"
        files_exist=false
    fi
    
    if $files_exist; then
        print_success "جميع ملفات النسخ الاحتياطي موجودة"
        return 0
    else
        return 1
    fi
}

# دالة فحص سلامة الملفات
validate_backup_integrity() {
    print_status "فحص سلامة ملفات النسخ الاحتياطي..."
    
    local files_valid=true
    
    # فحص صحة JSON
    for file in "$LATEST_STATE" "$PROJECT_PROGRESS" "$FILE_INVENTORY"; do
        if [[ -f "$file" ]]; then
            if jq empty "$file" 2>/dev/null; then
                print_success "ملف صالح: $(basename "$file")"
            else
                print_error "ملف JSON تالف: $(basename "$file")"
                files_valid=false
            fi
        fi
    done
    
    # فحص الـ checksum إذا كان متاحاً
    if [[ -f "$LATEST_STATE" ]]; then
        local stored_checksum=$(jq -r '.recovery_info.checksum' "$LATEST_STATE" 2>/dev/null | cut -d':' -f2)
        if [[ "$stored_checksum" != "null" && -n "$stored_checksum" ]]; then
            local current_checksum=$(sha256sum "$LATEST_STATE" | cut -d' ' -f1)
            if [[ "$stored_checksum" == "$current_checksum" ]]; then
                print_success "تحقق الـ checksum نجح"
            else
                print_warning "تحقق الـ checksum فشل - قد يكون الملف محدث"
            fi
        fi
    fi
    
    return $files_valid
}

# دالة استخراج معلومات الجلسة السابقة
extract_session_info() {
    print_status "استخراج معلومات الجلسة السابقة..."
    
    if [[ ! -f "$LATEST_STATE" ]]; then
        print_error "لا يمكن استخراج معلومات الجلسة - الملف غير موجود"
        return 1
    fi
    
    # استخراج المعلومات الأساسية
    SESSION_ID=$(jq -r '.session_info.session_id' "$LATEST_STATE")
    LAST_CHECKPOINT=$(jq -r '.session_info.last_checkpoint' "$LATEST_STATE")
    CURRENT_PROJECT=$(jq -r '.scan_progress.current_project.name' "$LATEST_STATE")
    CURRENT_DEPTH=$(jq -r '.scan_progress.current_project.current_depth' "$LATEST_STATE")
    FILES_SCANNED=$(jq -r '.scan_progress.current_project.files_scanned' "$LATEST_STATE")
    PROJECTS_COMPLETED=$(jq -r '.scan_progress.projects_completed' "$LATEST_STATE")
    TOTAL_FILES=$(jq -r '.statistics.total_files_scanned' "$LATEST_STATE")
    
    # عرض المعلومات
    echo
    echo -e "${BLUE}📋 معلومات الجلسة السابقة:${NC}"
    echo -e "   📅 معرف الجلسة: ${YELLOW}$SESSION_ID${NC}"
    echo -e "   ⏰ آخر حفظ: ${YELLOW}$LAST_CHECKPOINT${NC}"
    echo -e "   📂 المشروع الحالي: ${YELLOW}$CURRENT_PROJECT${NC}"
    echo -e "   📊 العمق الحالي: ${YELLOW}$CURRENT_DEPTH${NC}"
    echo -e "   📁 ملفات مفحوصة: ${YELLOW}$FILES_SCANNED${NC}"
    echo -e "   ✅ مشاريع مكتملة: ${YELLOW}$PROJECTS_COMPLETED${NC}"
    echo -e "   📈 إجمالي الملفات: ${YELLOW}$TOTAL_FILES${NC}"
    echo
    
    return 0
}

# دالة عرض خيارات الاستعادة
show_recovery_options() {
    echo -e "${BLUE}🔄 خيارات الاستعادة:${NC}"
    echo "   [1] استكمال الفحص من النقطة المحفوظة"
    echo "   [2] إعادة فحص المشروع الحالي من البداية"
    echo "   [3] بدء جلسة فحص جديدة"
    echo "   [4] عرض تفاصيل أكثر"
    echo "   [5] إلغاء"
    echo
}

# دالة الاستعادة
perform_recovery() {
    local choice=$1
    
    case $choice in
        1)
            print_status "استكمال الفحص من النقطة المحفوظة..."
            echo "RECOVERY_MODE=continue" > .kiro/recovery_mode
            echo "CURRENT_PROJECT=$CURRENT_PROJECT" >> .kiro/recovery_mode
            echo "CURRENT_DEPTH=$CURRENT_DEPTH" >> .kiro/recovery_mode
            echo "FILES_SCANNED=$FILES_SCANNED" >> .kiro/recovery_mode
            print_success "تم إعداد وضع الاستكمال"
            ;;
        2)
            print_status "إعادة فحص المشروع الحالي من البداية..."
            echo "RECOVERY_MODE=restart_project" > .kiro/recovery_mode
            echo "CURRENT_PROJECT=$CURRENT_PROJECT" >> .kiro/recovery_mode
            echo "CURRENT_DEPTH=1" >> .kiro/recovery_mode
            echo "FILES_SCANNED=0" >> .kiro/recovery_mode
            print_success "تم إعداد وضع إعادة الفحص"
            ;;
        3)
            print_status "بدء جلسة فحص جديدة..."
            echo "RECOVERY_MODE=new_session" > .kiro/recovery_mode
            print_success "تم إعداد وضع الجلسة الجديدة"
            ;;
        4)
            show_detailed_info
            return 1  # العودة لعرض الخيارات
            ;;
        5)
            print_status "تم إلغاء عملية الاستعادة"
            exit 0
            ;;
        *)
            print_error "خيار غير صالح: $choice"
            return 1
            ;;
    esac
    
    return 0
}

# دالة عرض التفاصيل المفصلة
show_detailed_info() {
    echo
    echo -e "${BLUE}📊 تفاصيل مفصلة للجلسة السابقة:${NC}"
    
    if [[ -f "$PROJECT_PROGRESS" ]]; then
        echo -e "${YELLOW}المشاريع المكتملة:${NC}"
        jq -r '.projects_detailed.completed[] | "   ✅ \(.name) - \(.files_count) ملف"' "$PROJECT_PROGRESS"
        
        echo -e "${YELLOW}المشاريع قيد التنفيذ:${NC}"
        jq -r '.projects_detailed.in_progress[] | "   🔄 \(.name) - \(.progress_percentage)% مكتمل"' "$PROJECT_PROGRESS"
        
        echo -e "${YELLOW}المشاريع المعلقة (أولوية عالية):${NC}"
        jq -r '.projects_detailed.pending_high_priority[] | "   ⏳ \(.name) - \(.estimated_files) ملف متوقع"' "$PROJECT_PROGRESS"
    fi
    
    if [[ -f "$FILE_INVENTORY" ]]; then
        echo -e "${YELLOW}إحصائيات الملفات:${NC}"
        echo -e "   📁 إجمالي الملفات: $(jq -r '.inventory_metadata.total_files_catalogued' "$FILE_INVENTORY")"
        echo -e "   📂 إجمالي المجلدات: $(jq -r '.inventory_metadata.total_folders_catalogued' "$FILE_INVENTORY")"
        echo -e "   🏗️ ملفات Kotlin: $(jq -r '.file_statistics.by_extension[".kt"]' "$FILE_INVENTORY")"
        echo -e "   🚀 ملفات Go: $(jq -r '.file_statistics.by_extension[".go"]' "$FILE_INVENTORY")"
        echo -e "   🎯 ملفات Dart: $(jq -r '.file_statistics.by_extension[".dart"]' "$FILE_INVENTORY")"
    fi
    
    echo
}

# دالة تسجيل عملية الاستعادة
log_recovery() {
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local message="$1"
    
    echo "[$timestamp] $message" >> "$RECOVERY_LOG"
}

# الدالة الرئيسية
main() {
    echo -e "${BLUE}🔄 نظام الاستعادة التلقائية للفحص الشامل${NC}"
    echo -e "${BLUE}================================================${NC}"
    echo
    
    # تسجيل بداية عملية الاستعادة
    log_recovery "بدء عملية الاستعادة التلقائية"
    
    # فحص وجود ملفات النسخ الاحتياطي
    if ! check_backup_files; then
        print_error "لا توجد ملفات نسخ احتياطي صالحة"
        print_status "بدء جلسة فحص جديدة..."
        echo "RECOVERY_MODE=new_session" > .kiro/recovery_mode
        log_recovery "لا توجد ملفات نسخ احتياطي - بدء جلسة جديدة"
        exit 0
    fi
    
    # فحص سلامة الملفات
    if ! validate_backup_integrity; then
        print_warning "بعض ملفات النسخ الاحتياطي قد تكون تالفة"
        print_status "محاولة الاستعادة من النسخ المتاحة..."
    fi
    
    # استخراج معلومات الجلسة
    if ! extract_session_info; then
        print_error "فشل في استخراج معلومات الجلسة"
        exit 1
    fi
    
    # عرض خيارات الاستعادة والحصول على اختيار المستخدم
    while true; do
        show_recovery_options
        
        # إذا كان في وضع تلقائي، اختر الخيار الأول
        if [[ "$1" == "--auto" ]]; then
            choice=1
            print_status "الوضع التلقائي: اختيار الاستكمال من النقطة المحفوظة"
        else
            read -p "اختر خياراً (1-5): " choice
        fi
        
        if perform_recovery "$choice"; then
            break
        fi
    done
    
    # تسجيل نجاح عملية الاستعادة
    log_recovery "تم إكمال عملية الاستعادة بنجاح - الخيار: $choice"
    
    echo
    print_success "تم إعداد الاستعادة بنجاح!"
    print_status "يمكنك الآن استكمال عملية الفحص"
    
    # عرض الخطوات التالية
    echo
    echo -e "${BLUE}📋 الخطوات التالية:${NC}"
    echo "   1. تشغيل عملية الفحص الرئيسية"
    echo "   2. ستتم قراءة إعدادات الاستعادة تلقائياً"
    echo "   3. سيتم استكمال الفحص من النقطة المحددة"
    echo
}

# تشغيل الدالة الرئيسية مع تمرير المعاملات
main "$@"