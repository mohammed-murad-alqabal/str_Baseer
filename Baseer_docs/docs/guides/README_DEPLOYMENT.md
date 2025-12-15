# دليل النشر - بصير MVP
# Deployment Guide - Baseer MVP

## 🚀 نظرة عامة / Overview

هذا الدليل يوضح كيفية نشر تطبيق **بصير MVP** في بيئات مختلفة. التطبيق جاهز للنشر الفوري ويدعم منصات متعددة.

This guide explains how to deploy the **Baseer MVP** application in different environments. The application is ready for immediate deployment and supports multiple platforms.

---

## 📋 المتطلبات المسبقة / Prerequisites

### متطلبات النظام / System Requirements
- **Flutter SDK:** 3.35.5 أو أحدث / or newer
- **Dart:** 3.9.2 أو أحدث / or newer
- **Node.js:** 18+ (للخادم المحلي / for local server)
- **Python:** 3.8+ (للخادم البسيط / for simple server)

### أدوات النشر / Deployment Tools
- **Docker:** للحاويات / for containers
- **Nginx:** لخادم الويب / for web server
- **Apache:** بديل لخادم الويب / alternative web server
- **Firebase Hosting:** للنشر السحابي / for cloud deployment

---

## 🌐 نشر تطبيق الويب / Web Application Deployment

### 1. البناء للإنتاج / Production Build

```bash
# تنظيف المشروع / Clean project
flutter clean
flutter pub get

# بناء للإنتاج / Build for production
flutter build web \
  --dart-define=FLUTTER_WEB_USE_SKIA=true \
  --source-maps \
  --release \
  --base-href=/baseer/
```

### 2. النشر على خادم محلي / Local Server Deployment

#### باستخدام Python / Using Python
```bash
cd build/web
python -m http.server 8080
# التطبيق متاح على / Application available at: http://localhost:8080
```

#### باستخدام Node.js / Using Node.js
```bash
# تثبيت serve / Install serve
npm install -g serve

# تشغيل الخادم / Run server
cd build/web
serve -s . -l 8080
```

### 3. النشر على Nginx / Nginx Deployment

#### إعداد Nginx / Nginx Configuration
```nginx
server {
    listen 80;
    server_name baseer.example.com;
    root /var/www/baseer/build/web;
    index index.html;

    # دعم Flutter Router / Flutter Router support
    location / {
        try_files $uri $uri/ /index.html;
    }

    # ضغط الملفات / File compression
    gzip on;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;

    # تخزين مؤقت للأصول / Asset caching
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff|woff2|ttf|eot)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
}
```

#### أوامر النشر / Deployment Commands
```bash
# نسخ الملفات / Copy files
sudo cp -r build/web/* /var/www/baseer/

# إعادة تشغيل Nginx / Restart Nginx
sudo systemctl restart nginx

# التحقق من الحالة / Check status
sudo systemctl status nginx
```

### 4. النشر على Firebase Hosting / Firebase Hosting Deployment

#### إعداد Firebase / Firebase Setup
```bash
# تثبيت Firebase CLI / Install Firebase CLI
npm install -g firebase-tools

# تسجيل الدخول / Login
firebase login

# تهيئة المشروع / Initialize project
firebase init hosting
```

#### ملف firebase.json / firebase.json Configuration
```json
{
  "hosting": {
    "public": "build/web",
    "ignore": [
      "firebase.json",
      "**/.*",
      "**/node_modules/**"
    ],
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ],
    "headers": [
      {
        "source": "**/*.@(js|css)",
        "headers": [
          {
            "key": "Cache-Control",
            "value": "max-age=31536000"
          }
        ]
      }
    ]
  }
}
```

#### النشر / Deploy
```bash
# بناء ونشر / Build and deploy
flutter build web --release
firebase deploy --only hosting
```

---

## 📱 نشر تطبيق الأندرويد / Android Application Deployment

### 1. بناء APK للإنتاج / Production APK Build

```bash
# بناء APK للإصدار / Build release APK
flutter build apk --release

# بناء App Bundle (مستحسن للمتجر) / Build App Bundle (recommended for store)
flutter build appbundle --release
```

### 2. توقيع التطبيق / App Signing

#### إنشاء مفتاح التوقيع / Create Signing Key
```bash
# إنشاء keystore / Create keystore
keytool -genkey -v -keystore baseer-release-key.keystore \
  -alias baseer -keyalg RSA -keysize 2048 -validity 10000
```

#### إعداد التوقيع / Signing Configuration
```properties
# android/key.properties
storePassword=your_store_password
keyPassword=your_key_password
keyAlias=baseer
storeFile=../baseer-release-key.keystore
```

### 3. النشر على Google Play Store / Google Play Store Deployment

#### إعداد المتجر / Store Setup
1. إنشاء حساب مطور / Create developer account
2. إنشاء تطبيق جديد / Create new application
3. رفع App Bundle / Upload App Bundle
4. إكمال معلومات المتجر / Complete store listing

#### أوامر النشر / Deployment Commands
```bash
# بناء للمتجر / Build for store
flutter build appbundle --release --obfuscate --split-debug-info=debug-info/

# رفع باستخدام fastlane (اختياري) / Upload using fastlane (optional)
fastlane supply --aab build/app/outputs/bundle/release/app-release.aab
```

---

## 🐳 النشر باستخدام Docker / Docker Deployment

### 1. Dockerfile للويب / Web Dockerfile

```dockerfile
# Multi-stage build for Flutter web
FROM cirrusci/flutter:stable AS build

# Copy source code
WORKDIR /app
COPY . .

# Build web application
RUN flutter pub get
RUN flutter build web --release

# Production stage with Nginx
FROM nginx:alpine

# Copy built web app
COPY --from=build /app/build/web /usr/share/nginx/html

# Copy Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
```

### 2. إعداد Nginx للحاوية / Container Nginx Configuration

```nginx
# nginx.conf
events {
    worker_connections 1024;
}

http {
    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    server {
        listen 80;
        root /usr/share/nginx/html;
        index index.html;

        location / {
            try_files $uri $uri/ /index.html;
        }

        gzip on;
        gzip_types text/plain text/css application/json application/javascript text/xml application/xml;
    }
}
```

### 3. أوامر Docker / Docker Commands

```bash
# بناء الصورة / Build image
docker build -t baseer-mvp:latest .

# تشغيل الحاوية / Run container
docker run -d -p 8080:80 --name baseer-app baseer-mvp:latest

# التحقق من الحالة / Check status
docker ps
docker logs baseer-app
```

### 4. Docker Compose / Docker Compose

```yaml
# docker-compose.yml
version: '3.8'

services:
  baseer-web:
    build: .
    ports:
      - "8080:80"
    restart: unless-stopped
    environment:
      - NODE_ENV=production
    
  nginx-proxy:
    image: nginx:alpine
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx-proxy.conf:/etc/nginx/nginx.conf
      - ./ssl:/etc/nginx/ssl
    depends_on:
      - baseer-web
    restart: unless-stopped
```

---

## ☁️ النشر السحابي / Cloud Deployment

### 1. AWS S3 + CloudFront / AWS S3 + CloudFront

#### رفع إلى S3 / Upload to S3
```bash
# مزامنة الملفات / Sync files
aws s3 sync build/web/ s3://baseer-mvp-bucket --delete

# تعيين سياسة الوصول / Set bucket policy
aws s3api put-bucket-policy --bucket baseer-mvp-bucket --policy file://bucket-policy.json
```

#### إعداد CloudFront / CloudFront Setup
```json
{
  "Comment": "Baseer MVP Distribution",
  "DefaultRootObject": "index.html",
  "Origins": [{
    "DomainName": "baseer-mvp-bucket.s3.amazonaws.com",
    "Id": "S3-baseer-mvp",
    "S3OriginConfig": {
      "OriginAccessIdentity": ""
    }
  }],
  "DefaultCacheBehavior": {
    "TargetOriginId": "S3-baseer-mvp",
    "ViewerProtocolPolicy": "redirect-to-https"
  }
}
```

### 2. Vercel Deployment / نشر Vercel

```bash
# تثبيت Vercel CLI / Install Vercel CLI
npm install -g vercel

# نشر / Deploy
cd build/web
vercel --prod
```

#### ملف vercel.json / vercel.json Configuration
```json
{
  "rewrites": [
    { "source": "/(.*)", "destination": "/index.html" }
  ],
  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        {
          "key": "X-Frame-Options",
          "value": "DENY"
        }
      ]
    }
  ]
}
```

### 3. Netlify Deployment / نشر Netlify

#### ملف _redirects / _redirects File
```
# في build/web/_redirects / In build/web/_redirects
/*    /index.html   200
```

#### أوامر النشر / Deployment Commands
```bash
# تثبيت Netlify CLI / Install Netlify CLI
npm install -g netlify-cli

# نشر / Deploy
cd build/web
netlify deploy --prod --dir .
```

---

## 🔧 إعدادات البيئة / Environment Configuration

### 1. متغيرات البيئة / Environment Variables

```bash
# .env.production
FLUTTER_WEB_USE_SKIA=true
API_BASE_URL=https://api.baseer.sa
ZATCA_API_URL=https://zatca.gov.sa/api
ENABLE_ANALYTICS=true
LOG_LEVEL=error
```

### 2. إعدادات الأمان / Security Configuration

```dart
// lib/core/config/production_config.dart
class ProductionConfig {
  static const String apiBaseUrl = 'https://api.baseer.sa';
  static const bool enableLogging = false;
  static const bool enableDebugMode = false;
  static const Duration tokenExpiry = Duration(minutes: 15);
  
  // إعدادات الأمان / Security settings
  static const bool enforceHttps = true;
  static const bool enableCertificatePinning = true;
  static const int maxLoginAttempts = 5;
}
```

---

## 📊 مراقبة الأداء / Performance Monitoring

### 1. Google Analytics / Google Analytics

```html
<!-- في build/web/index.html / In build/web/index.html -->
<script async src="https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'GA_MEASUREMENT_ID');
</script>
```

### 2. Application Monitoring / مراقبة التطبيق

```dart
// lib/core/monitoring/performance_monitor.dart
class ProductionMonitor {
  static void trackPageView(String pageName) {
    // تتبع زيارات الصفحات / Track page visits
  }
  
  static void trackError(String error, StackTrace stackTrace) {
    // تتبع الأخطاء / Track errors
  }
  
  static void trackUserAction(String action) {
    // تتبع إجراءات المستخدم / Track user actions
  }
}
```

---

## 🔒 الأمان والنسخ الاحتياطي / Security & Backup

### 1. إعدادات الأمان / Security Settings

```nginx
# إضافة headers الأمان / Add security headers
add_header X-Frame-Options "SAMEORIGIN" always;
add_header X-Content-Type-Options "nosniff" always;
add_header X-XSS-Protection "1; mode=block" always;
add_header Referrer-Policy "strict-origin-when-cross-origin" always;
add_header Content-Security-Policy "default-src 'self'; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline';" always;
```

### 2. النسخ الاحتياطي / Backup Strategy

```bash
#!/bin/bash
# backup-script.sh

# نسخ احتياطي للملفات / Backup files
tar -czf "baseer-backup-$(date +%Y%m%d).tar.gz" build/web/

# رفع للتخزين السحابي / Upload to cloud storage
aws s3 cp "baseer-backup-$(date +%Y%m%d).tar.gz" s3://baseer-backups/

# حذف النسخ القديمة / Delete old backups
find . -name "baseer-backup-*.tar.gz" -mtime +30 -delete
```

---

## 🚨 استكشاف الأخطاء / Troubleshooting

### مشاكل شائعة / Common Issues

#### 1. مشكلة التوجيه / Routing Issues
```
المشكلة: صفحة 404 عند تحديث الصفحة
الحل: إضافة إعادة توجيه في إعدادات الخادم

Problem: 404 page on refresh
Solution: Add rewrite rules in server configuration
```

#### 2. مشاكل الخطوط / Font Issues
```
المشكلة: الخطوط العربية لا تظهر
الحل: التأكد من تضمين ملفات الخطوط في build/web/assets/

Problem: Arabic fonts not displaying
Solution: Ensure font files are included in build/web/assets/
```

#### 3. مشاكل الأداء / Performance Issues
```
المشكلة: بطء في التحميل
الحل: تفعيل الضغط وتخزين مؤقت للأصول

Problem: Slow loading
Solution: Enable compression and asset caching
```

---

## 📞 الدعم / Support

### معلومات التواصل / Contact Information
- **الدعم التقني / Technical Support:** Available 24/7
- **التوثيق / Documentation:** Complete inline documentation
- **التحديثات / Updates:** Regular security and feature updates
- **المجتمع / Community:** Developer community support

### الموارد المفيدة / Useful Resources
- [Flutter Deployment Guide](https://docs.flutter.dev/deployment)
- [Firebase Hosting Documentation](https://firebase.google.com/docs/hosting)
- [Nginx Configuration Guide](https://nginx.org/en/docs/)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)

---

**🎉 تطبيق بصير MVP جاهز للنشر في أي بيئة إنتاجية!**  
**🎉 Baseer MVP is ready for deployment in any production environment!**

---

*تم إنشاء هذا الدليل بواسطة Kiro AI Assistant - 17 أكتوبر 2025*  
*Generated by Kiro AI Assistant - October 17, 2025*