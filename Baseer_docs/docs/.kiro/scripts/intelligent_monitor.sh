#!/bin/bash

# نظام المراقبة الذكية المستمرة
intelligent_monitoring() {
    echo "👁️ بدء المراقبة الذكية..."
    
    while true; do
        timestamp=$(date '+%Y-%m-%d %H:%M:%S')
        
        # مراقبة الأداء
        echo "[$timestamp] 📊 فحص الأداء..."
        
        # فحص استخدام الذاكرة
        memory_usage=$(free | grep Mem | awk '{printf "%.1f", $3/$2 * 100.0}')
        if (( $(echo "$memory_usage > 80" | bc -l) )); then
            echo "⚠️ تحذير: استخدام الذاكرة عالي ($memory_usage%)"
        fi
        
        # فحص مساحة القرص
        disk_usage=$(df . | tail -1 | awk '{print $5}' | sed 's/%//')
        if [ "$disk_usage" -gt 85 ]; then
            echo "⚠️ تحذير: مساحة القرص منخفضة ($disk_usage%)"
        fi
        
        # فحص العمليات
        process_count=$(ps aux | wc -l)
        echo "[$timestamp] 🔄 العمليات النشطة: $process_count"
        
        # فحص الشبكة (إذا كانت متاحة)
        if command -v ping >/dev/null 2>&1; then
            if ping -c 1 google.com >/dev/null 2>&1; then
                echo "[$timestamp] 🌐 الاتصال بالإنترنت: متاح"
            else
                echo "[$timestamp] ❌ الاتصال بالإنترنت: غير متاح"
            fi
        fi
        
        # حفظ الإحصائيات
        echo "$timestamp,$memory_usage,$disk_usage,$process_count" >> .kiro/monitoring/stats.csv
        
        sleep 30
    done
}

intelligent_monitoring
