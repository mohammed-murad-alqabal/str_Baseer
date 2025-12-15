#!/bin/bash

echo "🛑 إيقاف جميع الأنظمة الذكية..."

# إيقاف جميع العمليات
for pid_file in .kiro/runtime/*.pid; do
    if [ -f "$pid_file" ]; then
        pid=$(cat "$pid_file")
        system_name=$(basename "$pid_file" .pid)
        echo "⏹️ إيقاف $system_name (PID: $pid)..."
        kill "$pid" 2>/dev/null || true
        rm "$pid_file"
    fi
done

# تنظيف العمليات المتبقية
pkill -f "file_watcher.sh" 2>/dev/null || true
pkill -f "intelligent_monitor.sh" 2>/dev/null || true
pkill -f "continuous_learning.sh" 2>/dev/null || true
pkill -f "smart_alerts.sh" 2>/dev/null || true

echo "✅ تم إيقاف جميع الأنظمة بنجاح"
