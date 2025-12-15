#!/bin/bash

# نظام التنبيهات الذكية
smart_alerts() {
    echo "🚨 بدء نظام التنبيهات الذكية..."
    
    send_alert() {
        local level="$1"
        local message="$2"
        local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
        
        # حفظ التنبيه
        echo "[$timestamp] [$level] $message" >> .kiro/monitoring/alerts.log
        
        # عرض التنبيه
        case "$level" in
            "CRITICAL")
                echo "🚨 حرج: $message"
                ;;
            "WARNING")
                echo "⚠️ تحذير: $message"
                ;;
            "INFO")
                echo "ℹ️ معلومات: $message"
                ;;
        esac
    }
    
    # مراقبة الأخطاء الحرجة
    if [ -d backend/logs ]; then
        tail -f backend/logs/*.log 2>/dev/null | while read line; do
            if echo "$line" | grep -q "FATAL\|PANIC"; then
                send_alert "CRITICAL" "خطأ حرج في النظام: $line"
            elif echo "$line" | grep -q "ERROR"; then
                send_alert "WARNING" "خطأ في النظام: $line"
            fi
        done &
    fi
    
    # مراقبة الأداء
    while true; do
        # فحص الذاكرة
        memory_usage=$(free | grep Mem | awk '{printf "%.1f", $3/$2 * 100.0}')
        if (( $(echo "$memory_usage > 90" | bc -l) )); then
            send_alert "CRITICAL" "استخدام الذاكرة حرج: $memory_usage%"
        elif (( $(echo "$memory_usage > 80" | bc -l) )); then
            send_alert "WARNING" "استخدام الذاكرة عالي: $memory_usage%"
        fi
        
        sleep 60
    done
}

smart_alerts
