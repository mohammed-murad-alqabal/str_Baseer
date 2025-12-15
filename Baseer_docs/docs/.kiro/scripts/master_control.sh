#!/bin/bash

# نظام التحكم الرئيسي
master_control() {
    echo "🎯 بدء نظام التحكم الرئيسي..."
    
    # إنشاء ملف PID للتحكم
    echo $$ > .kiro/runtime/master.pid
    
    # تشغيل جميع الأنظمة الفرعية
    echo "🚀 تشغيل الأنظمة الفرعية..."
    
    # تشغيل مراقبة الملفات
    .kiro/scripts/file_watcher.sh > .kiro/logs/file_watcher.log 2>&1 &
    echo $! > .kiro/runtime/file_watcher.pid
    
    # تشغيل المراقبة الذكية
    .kiro/scripts/intelligent_monitor.sh > .kiro/logs/intelligent_monitor.log 2>&1 &
    echo $! > .kiro/runtime/intelligent_monitor.pid
    
    # تشغيل التعلم المستمر
    .kiro/scripts/continuous_learning.sh > .kiro/logs/continuous_learning.log 2>&1 &
    echo $! > .kiro/runtime/continuous_learning.pid
    
    # تشغيل التنبيهات الذكية
    .kiro/scripts/smart_alerts.sh > .kiro/logs/smart_alerts.log 2>&1 &
    echo $! > .kiro/runtime/smart_alerts.pid
    
    echo "✅ جميع الأنظمة نشطة!"
    echo "📊 لمراقبة الحالة: tail -f .kiro/logs/*.log"
    echo "🛑 لإيقاف النظام: .kiro/scripts/stop_all.sh"
    
    # مراقبة الأنظمة الفرعية
    while true; do
        # فحص حالة الأنظمة
        for pid_file in .kiro/runtime/*.pid; do
            if [ -f "$pid_file" ]; then
                pid=$(cat "$pid_file")
                if ! kill -0 "$pid" 2>/dev/null; then
                    system_name=$(basename "$pid_file" .pid)
                    echo "⚠️ النظام $system_name توقف - إعادة تشغيل..."
                    # يمكن إضافة منطق إعادة التشغيل هنا
                fi
            fi
        done
        
        sleep 30
    done
}

# التعامل مع إشارات الإيقاف
cleanup() {
    echo "🛑 إيقاف جميع الأنظمة..."
    for pid_file in .kiro/runtime/*.pid; do
        if [ -f "$pid_file" ]; then
            pid=$(cat "$pid_file")
            kill "$pid" 2>/dev/null || true
            rm "$pid_file"
        fi
    done
    exit 0
}

trap cleanup SIGINT SIGTERM

master_control
