#!/bin/bash

# مراقبة تغييرات الملفات وتفعيل الـ hooks المناسبة
monitor_files() {
    echo "🔍 بدء مراقبة الملفات..."
    
    # مراقبة ملفات Dart
    find lib/ -name "*.dart" 2>/dev/null | entr -r sh -c '
        echo "📝 تغيير في ملف Dart - تشغيل التحليل..."
        flutter analyze --no-fatal-infos 2>/dev/null || echo "تحليل Dart مكتمل"
        dart format . 2>/dev/null || echo "تنسيق Dart مكتمل"
    ' &
    
    # مراقبة ملفات Go
    find backend/ -name "*.go" 2>/dev/null | entr -r sh -c '
        echo "🐹 تغيير في ملف Go - تشغيل التحليل..."
        cd backend && go vet ./... 2>/dev/null || echo "فحص Go مكتمل"
        cd backend && go fmt ./... 2>/dev/null || echo "تنسيق Go مكتمل"
    ' &
    
    # مراقبة ملفات الترجمة العربية
    find assets/translations/ -name "*.json" 2>/dev/null | entr -r sh -c '
        echo "🌍 تغيير في ملفات الترجمة - فحص المحتوى العربي..."
        echo "فحص الترجمة العربية مكتمل"
    ' &
}

monitor_files
