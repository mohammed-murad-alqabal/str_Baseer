# 📚 دليل المطور - Baseer

## 🎯 نظرة عامة

هذا الدليل مخصص للمطورين الذين يعملون على مشروع Baseer. يحتوي على جميع المعلومات التقنية اللازمة للتطوير والصيانة.

---

## 🏗️ البنية التقنية

### المكدس التقني
- **Frontend**: Flutter 3.16.0 + Dart 3.0
- **Backend**: Go 1.21 + Gin Framework
- **Database**: PostgreSQL 15 + Redis 7.2
- **Infrastructure**: AWS + Docker

### الأدوات المطلوبة
- Go 1.21 أو أحدث
- Flutter 3.16.0 أو أحدث
- Docker & Docker Compose
- PostgreSQL 15
- Redis 7.2

---

## 🚀 البدء السريع

### 1. إعداد البيئة
```bash
# استنساخ المشروع
git clone https://github.com/baseer-app/baseer.git
cd baseer

# تشغيل سكريبت الإعداد
./setup.sh
```

### 2. تشغيل الخدمات
```bash
# تشغيل قواعد البيانات
docker-compose -f docker-compose.dev.yml up -d

# تشغيل Backend
cd backend && go run cmd/main.go

# تشغيل Frontend (في terminal جديد)
cd frontend && flutter run
```

---

## 📁 هيكل المشروع

### Backend Structure
```
backend/
├── cmd/                 # نقطة البداية
├── internal/            # الكود الداخلي
│   ├── handlers/        # معالجات HTTP
│   ├── models/          # نماذج البيانات
│   ├── services/        # منطق الأعمال
│   ├── middleware/      # البرمجيات الوسطية
│   └── config/          # الإعدادات
├── pkg/                 # المكتبات المشتركة
└── migrations/          # هجرة قاعدة البيانات
```

### Frontend Structure
```
frontend/
├── lib/
│   ├── core/            # الوظائف الأساسية
│   ├── features/        # الميزات الرئيسية
│   └── shared/          # المكونات المشتركة
├── test/                # الاختبارات
└── assets/              # الملفات الثابتة
```

---

## 🔧 التطوير

### Backend Development
```bash
# تشغيل الخادم في وضع التطوير
cd backend
go run cmd/main.go

# تشغيل الاختبارات
go test ./...

# بناء المشروع
go build -o bin/main cmd/main.go
```

### Frontend Development
```bash
# تشغيل التطبيق
cd frontend
flutter run

# تشغيل الاختبارات
flutter test

# بناء التطبيق
flutter build apk
```

---

## 🧪 الاختبارات

### Backend Tests
```bash
# جميع الاختبارات
go test ./...

# اختبارات محددة
go test ./internal/handlers

# اختبارات مع التغطية
go test -cover ./...
```

### Frontend Tests
```bash
# اختبارات الوحدة
flutter test

# اختبارات التكامل
flutter test integration_test/
```

---

## 📊 قاعدة البيانات

### PostgreSQL
- **Host**: localhost:5432
- **Database**: baseer_dev
- **Username**: baseer
- **Password**: baseer123

### Redis
- **Host**: localhost:6379
- **Password**: baseer123

### Migrations
```bash
# تشغيل الهجرات
cd backend
go run cmd/migrate/main.go up

# إعادة الهجرات
go run cmd/migrate/main.go down
```

---

## 🔒 الأمان

### Authentication
- **JWT Tokens**: للمصادقة
- **bcrypt**: لتشفير كلمات المرور
- **Rate Limiting**: لمنع الهجمات

### Security Headers
- **CORS**: مُعد للسماح بالطلبات من Frontend
- **Helmet**: لرؤوس الأمان
- **Input Validation**: لجميع المدخلات

---

## 📈 المراقبة

### Prometheus
- **URL**: http://localhost:9090
- **Metrics**: /metrics endpoint

### Grafana
- **URL**: http://localhost:3001
- **Username**: admin
- **Password**: baseer123

---

## 🚀 النشر

### Development
```bash
# بناء الصور
docker-compose -f docker-compose.dev.yml build

# تشغيل الخدمات
docker-compose -f docker-compose.dev.yml up -d
```

### Production
```bash
# بناء للإنتاج
docker-compose -f docker-compose.prod.yml build

# نشر للإنتاج
./scripts/deployment/deploy.sh
```

---

## 🐛 Debugging

### Backend Debugging
```bash
# تشغيل مع Debug
go run -race cmd/main.go

# تحليل الذاكرة
go tool pprof http://localhost:8080/debug/pprof/heap
```

### Frontend Debugging
```bash
# تشغيل مع Debug
flutter run --debug

# تحليل الأداء
flutter run --profile
```

---

## 📝 Best Practices

### Code Style
- **Go**: استخدام `gofmt` و `golint`
- **Dart**: استخدام `dart format` و `dart analyze`

### Git Workflow
- **Branches**: `main`, `develop`, `feature/*`
- **Commits**: استخدام Conventional Commits
- **PR**: مراجعة الكود مطلوبة

### Testing
- **Coverage**: 90%+ للكود الجديد
- **E2E**: اختبار جميع المسارات الحرجة
- **Performance**: اختبارات الأداء للـ API

---

## 📞 الدعم

- **Documentation**: [docs.baseer.app](https://docs.baseer.app)
- **Issues**: [GitHub Issues](https://github.com/baseer-app/baseer/issues)
- **Discord**: [Baseer Developers](https://discord.gg/baseer)

---

**"نحن نبني مستقبلاً مالياً أفضل للمنطقة العربية"** 🚀
