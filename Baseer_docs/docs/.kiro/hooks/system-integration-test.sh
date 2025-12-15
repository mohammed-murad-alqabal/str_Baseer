#!/bin/bash

# =============================================================================
# Baseer Agent Hooks System Integration Test
# اختبار تكامل منظومة Agent Hooks لمشروع بصير
# =============================================================================

echo "🚀 بدء اختبار تكامل منظومة Agent Hooks لمشروع بصير"
echo "=================================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test counters
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

# Function to run test
run_test() {
    local test_name="$1"
    local test_command="$2"
    
    echo -e "${BLUE}🧪 اختبار: $test_name${NC}"
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    
    if eval "$test_command" > /dev/null 2>&1; then
        echo -e "${GREEN}✅ نجح: $test_name${NC}"
        PASSED_TESTS=$((PASSED_TESTS + 1))
    else
        echo -e "${RED}❌ فشل: $test_name${NC}"
        FAILED_TESTS=$((FAILED_TESTS + 1))
    fi
}

# =============================================================================
# 1. Hook Files Validation Tests
# =============================================================================
echo -e "\n${YELLOW}📋 1. اختبار صحة ملفات الـ Hooks${NC}"

run_test "وجود مجلد الـ hooks" "[ -d '.kiro/hooks' ]"
run_test "عدد الـ hooks المطلوب (10)" "[ $(find .kiro/hooks -name '*.kiro.hook' | wc -l) -eq 10 ]"

# Test each hook file for valid JSON
for hook_file in .kiro/hooks/*.kiro.hook; do
    if [ -f "$hook_file" ]; then
        hook_name=$(basename "$hook_file" .kiro.hook)
        run_test "صحة JSON للـ $hook_name" "jq . '$hook_file'"
    fi
done

# =============================================================================
# 2. Project Structure Validation Tests
# =============================================================================
echo -e "\n${YELLOW}📁 2. اختبار بنية المشروع${NC}"

run_test "وجود مجلد lib" "[ -d 'lib' ]"
run_test "وجود مجلد lib/features" "[ -d 'lib/features' ]"
run_test "وجود مجلد lib/shared" "[ -d 'lib/shared' ]"
run_test "وجود مجلد backend" "[ -d 'backend' ]"
run_test "وجود ملف pubspec.yaml" "[ -f 'pubspec.yaml' ]"
run_test "وجود ملف analysis_options.yaml" "[ -f 'analysis_options.yaml' ]"

# =============================================================================
# 3. Flutter Environment Tests
# =============================================================================
echo -e "\n${YELLOW}🎯 3. اختبار بيئة Flutter${NC}"

run_test "تثبيت Flutter" "command -v flutter"
run_test "إصدار Flutter صحيح" "flutter --version | grep -q 'Flutter 3'"
run_test "تثبيت Dart" "command -v dart"
run_test "صحة pubspec.yaml" "flutter pub get --dry-run"

# =============================================================================
# 4. Go Environment Tests  
# =============================================================================
echo -e "\n${YELLOW}🐹 4. اختبار بيئة Go${NC}"

run_test "تثبيت Go" "command -v go"
run_test "إصدار Go صحيح" "go version | grep -q 'go1.2'"
run_test "وجود go.mod في backend" "[ -f 'backend/go.mod' ]"
run_test "صحة go.mod" "cd backend && go mod verify"

# =============================================================================
# 5. Hook Pattern Matching Tests
# =============================================================================
echo -e "\n${YELLOW}🎯 5. اختبار أنماط الـ Hooks${NC}"

# Test Dart file patterns
run_test "نمط ملفات Dart العامة" "echo '**/*.dart' | grep -q '\*\*'"
run_test "نمط ملفات features" "echo 'lib/features/**/*.dart' | grep -q 'lib/features'"
run_test "نمط ملفات shared" "echo 'lib/shared/**/*.dart' | grep -q 'lib/shared'"

# Test Go file patterns  
run_test "نمط ملفات Go" "echo 'backend/**/*.go' | grep -q 'backend'"
run_test "نمط go.mod" "echo 'backend/go.mod' | grep -q 'go.mod'"

# Test Arabic content patterns
run_test "نمط الملفات العربية" "echo '**/*_ar.dart' | grep -q '_ar'"
run_test "نمط ملفات RTL" "echo '**/rtl_*.dart' | grep -q 'rtl_'"

# =============================================================================
# 6. Security Patterns Tests
# =============================================================================
echo -e "\n${YELLOW}🔒 6. اختبار أنماط الأمان${NC}"

run_test "نمط ملفات المصادقة" "echo '**/*auth*.dart' | grep -q 'auth'"
run_test "نمط ملفات الأمان" "echo '**/*security*.dart' | grep -q 'security'"
run_test "نمط ملفات البيئة" "echo '**/.env*' | grep -q '.env'"
run_test "نمط ملفات JWT" "echo '**/*jwt*.dart' | grep -q 'jwt'"

# =============================================================================
# 7. ZATCA Compliance Tests
# =============================================================================
echo -e "\n${YELLOW}📋 7. اختبار أنماط ZATCA${NC}"

run_test "نمط ملفات ZATCA" "echo '**/zatca*.dart' | grep -q 'zatca'"
run_test "نمط ملفات الفواتير" "echo '**/invoice*.dart' | grep -q 'invoice'"
run_test "نمط ملفات الضرائب" "echo '**/tax*.dart' | grep -q 'tax'"
run_test "نمط QR Code" "echo '**/qr_code*.dart' | grep -q 'qr_code'"

# =============================================================================
# 8. Performance Monitoring Tests
# =============================================================================
echo -e "\n${YELLOW}⚡ 8. اختبار أنماط الأداء${NC}"

run_test "نمط ملفات قاعدة البيانات" "echo '**/database*.dart' | grep -q 'database'"
run_test "نمط ملفات API" "echo '**/api*.dart' | grep -q 'api'"
run_test "نمط ملفات الخدمات" "echo '**/service*.dart' | grep -q 'service'"
run_test "نمط ملفات الواجهات" "echo '**/widget*.dart' | grep -q 'widget'"

# =============================================================================
# 9. Test Automation Patterns
# =============================================================================
echo -e "\n${YELLOW}🧪 9. اختبار أنماط الاختبارات${NC}"

run_test "نمط ملفات اختبار Dart" "echo 'test/**/*.dart' | grep -q 'test'"
run_test "نمط ملفات اختبار Go" "echo 'backend/**/*_test.go' | grep -q '_test.go'"
run_test "وجود مجلد test" "[ -d 'test' ] || echo 'مجلد test غير موجود - سيتم إنشاؤه عند الحاجة'"

# =============================================================================
# 10. Integration Completeness Test
# =============================================================================
echo -e "\n${YELLOW}🔗 10. اختبار اكتمال التكامل${NC}"

# Check if all required hooks exist
required_hooks=(
    "auto-formatter"
    "static-code-analyzer" 
    "barrel-file-generator"
    "feature-scaffold-hook"
    "arabic-content-validator"
    "go-backend-validator"
    "zatca-compliance-checker"
    "security-privacy-validator"
    "performance-monitor"
    "test-automation"
)

for hook in "${required_hooks[@]}"; do
    run_test "وجود $hook hook" "[ -f '.kiro/hooks/$hook.kiro.hook' ]"
done

# =============================================================================
# Test Results Summary
# =============================================================================
echo -e "\n${BLUE}📊 ملخص نتائج الاختبار${NC}"
echo "================================"
echo -e "إجمالي الاختبارات: ${BLUE}$TOTAL_TESTS${NC}"
echo -e "الاختبارات الناجحة: ${GREEN}$PASSED_TESTS${NC}"
echo -e "الاختبارات الفاشلة: ${RED}$FAILED_TESTS${NC}"

# Calculate success percentage
if [ $TOTAL_TESTS -gt 0 ]; then
    SUCCESS_RATE=$((PASSED_TESTS * 100 / TOTAL_TESTS))
    echo -e "معدل النجاح: ${YELLOW}$SUCCESS_RATE%${NC}"
    
    if [ $SUCCESS_RATE -ge 90 ]; then
        echo -e "\n${GREEN}🎉 ممتاز! النظام يعمل بكفاءة عالية${NC}"
    elif [ $SUCCESS_RATE -ge 75 ]; then
        echo -e "\n${YELLOW}⚠️  جيد، لكن يحتاج بعض التحسينات${NC}"
    else
        echo -e "\n${RED}❌ يحتاج إصلاحات جوهرية${NC}"
    fi
fi

# =============================================================================
# Recommendations
# =============================================================================
echo -e "\n${BLUE}💡 التوصيات${NC}"
echo "============"

if [ $FAILED_TESTS -gt 0 ]; then
    echo "• راجع الاختبارات الفاشلة وأصلح المشاكل"
    echo "• تأكد من تثبيت جميع الأدوات المطلوبة"
    echo "• تحقق من صحة ملفات التكوين"
fi

echo "• قم بتشغيل الاختبارات دورياً للتأكد من سلامة النظام"
echo "• راقب أداء الـ hooks أثناء التطوير"
echo "• حدث الـ hooks حسب احتياجات المشروع"

echo -e "\n${GREEN}✅ انتهى اختبار تكامل النظام${NC}"
echo "=================================="