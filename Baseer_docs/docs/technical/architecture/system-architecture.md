# 🏗️ التصميم المعماري - Baseer

## 📋 معلومات الوثيقة

| الحقل | القيمة |
|-------|--------|
| **اسم المشروع** | Baseer - نظام التشغيل المالي الذكي |
| **الإصدار** | 1.0.0 |
| **التاريخ** | 21 أكتوبر 2025 |
| **المؤلف** | فريق التطوير |
| **الحالة** | مسودة أولية |
| **المراجعة** | v1.0 |

---

## 🎯 نظرة عامة معمارية

### الرؤية المعمارية
Baseer هو نظام تشغيل مالي ذكي متكامل مصمم للمنطقة العربية، يجمع بين إدارة التمويل الشخصي ومحاسبة الأعمال باستخدام الذكاء الاصطناعي المتقدم.

### المبادئ المعمارية
1. **Microservices Architecture** - خدمات منفصلة وقابلة للتوسع
2. **Domain-Driven Design** - تصميم مدفوع بالمجال
3. **Event-Driven Architecture** - معمارية مدفوعة بالأحداث
4. **API-First Design** - تصميم API أولاً
5. **Security by Design** - الأمان في التصميم
6. **Scalability** - قابلية التوسع الأفقي والعمودي

---

## 🏛️ البنية المعمارية العامة

### 1. طبقة العرض (Presentation Layer)
```
┌─────────────────────────────────────────┐
│              Frontend Layer             │
├─────────────────────────────────────────┤
│  Flutter Mobile App  │  Web Dashboard   │
│  - iOS & Android     │  - Admin Panel   │
│  - Material Design  │  - Analytics     │
│  - Offline Support  │  - Reports       │
└─────────────────────────────────────────┘
```

### 2. طبقة API Gateway
```
┌─────────────────────────────────────────┐
│              API Gateway                │
├─────────────────────────────────────────┤
│  - Authentication & Authorization       │
│  - Rate Limiting & Throttling          │
│  - Request Routing & Load Balancing    │
│  - API Versioning & Documentation      │
│  - Monitoring & Logging                │
└─────────────────────────────────────────┘
```

### 3. طبقة الخدمات (Services Layer)
```
┌─────────────────────────────────────────┐
│            Microservices Layer          │
├─────────────────────────────────────────┤
│  Auth Service    │  Invoice Service    │
│  User Service    │  OCR Service        │
│  Customer Service│  Analytics Service  │
│  Payment Service │  Notification Svc   │
└─────────────────────────────────────────┘
```

### 4. طبقة البيانات (Data Layer)
```
┌─────────────────────────────────────────┐
│              Data Layer                 │
├─────────────────────────────────────────┤
│  PostgreSQL      │  Redis Cache        │
│  - Users         │  - Sessions         │
│  - Invoices      │  - API Cache         │
│  - Customers     │  - Rate Limiting    │
│  - Transactions  │  - Real-time Data   │
└─────────────────────────────────────────┘
```

### 5. طبقة البنية التحتية (Infrastructure Layer)
```
┌─────────────────────────────────────────┐
│           Infrastructure Layer           │
├─────────────────────────────────────────┤
│  AWS Services    │  Monitoring         │
│  - EC2/ECS       │  - Prometheus       │
│  - RDS           │  - Grafana          │
│  - ElastiCache   │  - ELK Stack        │
│  - S3            │  - Sentry           │
└─────────────────────────────────────────┘
```

---

## 🔧 المكونات التقنية التفصيلية

### Frontend Architecture (Flutter)

#### 1. Clean Architecture Pattern
```
lib/
├── core/                    # الطبقة الأساسية
│   ├── constants/          # الثوابت العامة
│   ├── theme/              # نظام التصميم
│   ├── utils/              # الأدوات المساعدة
│   ├── network/            # إعدادات الشبكة
│   ├── error/              # معالجة الأخطاء
│   └── extensions/         # امتدادات Dart
├── features/                # طبقة الميزات
│   ├── auth/               # المصادقة
│   │   ├── data/           # مصادر البيانات
│   │   ├── domain/         # منطق الأعمال
│   │   └── presentation/   # واجهة المستخدم
│   ├── dashboard/          # لوحة التحكم
│   ├── invoices/           # الفواتير
│   ├── expenses/           # المصروفات
│   ├── customers/          # العملاء
│   └── ocr/               # مسح الإيصالات
├── shared/                  # المكونات المشتركة
│   ├── widgets/            # عناصر واجهة المستخدم
│   ├── models/             # نماذج البيانات
│   ├── services/           # الخدمات المشتركة
│   └── repositories/       # مستودعات البيانات
└── main.dart               # نقطة البداية
```

#### 2. State Management (Riverpod)
```dart
// Provider للبيانات
final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  return UserNotifier(ref.read(userRepository));
});

// Provider للخدمات
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(ref.read(dioProvider));
});
```

### Backend Architecture (Go)

#### 1. Clean Architecture Pattern
```
backend/
├── cmd/                     # نقطة البداية
│   ├── main.go             # الخادم الرئيسي
│   └── migrate/            # هجرة قاعدة البيانات
├── internal/                # الكود الداخلي
│   ├── domain/              # طبقة المجال
│   │   ├── entities/        # الكيانات
│   │   ├── repositories/    # واجهات المستودعات
│   │   └── services/        # خدمات المجال
│   ├── infrastructure/      # طبقة البنية التحتية
│   │   ├── database/        # قاعدة البيانات
│   │   ├── cache/           # التخزين المؤقت
│   │   ├── storage/         # تخزين الملفات
│   │   └── external/        # الخدمات الخارجية
│   ├── application/         # طبقة التطبيق
│   │   ├── handlers/        # معالجات HTTP
│   │   ├── middleware/      # البرمجيات الوسطية
│   │   ├── dto/             # كائنات نقل البيانات
│   │   └── usecases/        # حالات الاستخدام
│   └── config/              # الإعدادات
├── pkg/                     # المكتبات المشتركة
│   ├── utils/               # الأدوات المساعدة
│   ├── logger/              # نظام السجلات
│   ├── validator/           # التحقق من البيانات
│   └── crypto/              # التشفير
└── migrations/              # هجرة قاعدة البيانات
```

#### 2. Microservices Structure
```
services/
├── auth-service/            # خدمة المصادقة
├── user-service/            # خدمة المستخدمين
├── invoice-service/         # خدمة الفواتير
├── customer-service/        # خدمة العملاء
├── ocr-service/            # خدمة OCR
├── payment-service/         # خدمة المدفوعات
├── analytics-service/       # خدمة التحليلات
└── notification-service/    # خدمة الإشعارات
```

---

## 🗄️ تصميم قاعدة البيانات

### PostgreSQL Schema Design

#### 1. Users Table
```sql
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    business_name VARCHAR(200),
    business_type VARCHAR(50),
    tax_number VARCHAR(15),
    cr_number VARCHAR(10),
    subscription_plan VARCHAR(20) DEFAULT 'free',
    subscription_status VARCHAR(20) DEFAULT 'active',
    email_verified BOOLEAN DEFAULT FALSE,
    phone_verified BOOLEAN DEFAULT FALSE,
    two_factor_enabled BOOLEAN DEFAULT FALSE,
    last_login TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### 2. Invoices Table
```sql
CREATE TABLE invoices (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id),
    customer_id UUID NOT NULL REFERENCES customers(id),
    invoice_number VARCHAR(50) UNIQUE NOT NULL,
    invoice_type VARCHAR(20) DEFAULT 'standard',
    status VARCHAR(20) DEFAULT 'draft',
    issue_date DATE NOT NULL,
    due_date DATE NOT NULL,
    subtotal DECIMAL(15,2) NOT NULL,
    tax_amount DECIMAL(15,2) DEFAULT 0,
    discount_amount DECIMAL(15,2) DEFAULT 0,
    total_amount DECIMAL(15,2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'SAR',
    payment_method VARCHAR(50),
    payment_status VARCHAR(20) DEFAULT 'unpaid',
    paid_amount DECIMAL(15,2) DEFAULT 0,
    paid_date TIMESTAMP,
    payment_reference VARCHAR(100),
    zatca_uuid VARCHAR(100),
    zatca_hash VARCHAR(255),
    qr_code TEXT,
    xml_content TEXT,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### 3. Invoice Items Table
```sql
CREATE TABLE invoice_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    invoice_id UUID NOT NULL REFERENCES invoices(id),
    item_name VARCHAR(200) NOT NULL,
    description TEXT,
    quantity DECIMAL(10,3) NOT NULL,
    unit_price DECIMAL(15,2) NOT NULL,
    discount DECIMAL(5,2) DEFAULT 0,
    discount_type VARCHAR(20) DEFAULT 'percentage',
    tax_rate DECIMAL(5,2) DEFAULT 15,
    line_total DECIMAL(15,2) NOT NULL,
    discount_amount DECIMAL(15,2) DEFAULT 0,
    tax_amount DECIMAL(15,2) DEFAULT 0,
    total_amount DECIMAL(15,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### 4. Customers Table
```sql
CREATE TABLE customers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id),
    name VARCHAR(200) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(20),
    address TEXT,
    city VARCHAR(100),
    region VARCHAR(100),
    postal_code VARCHAR(20),
    country VARCHAR(2) DEFAULT 'SA',
    tax_number VARCHAR(15),
    cr_number VARCHAR(10),
    customer_type VARCHAR(20) DEFAULT 'individual',
    notes TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### 5. Expenses Table
```sql
CREATE TABLE expenses (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id),
    amount DECIMAL(15,2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'SAR',
    category VARCHAR(100) NOT NULL,
    subcategory VARCHAR(100),
    description TEXT,
    expense_date DATE NOT NULL,
    merchant_name VARCHAR(200),
    receipt_image_url TEXT,
    ocr_data JSONB,
    tags TEXT[],
    is_business BOOLEAN DEFAULT FALSE,
    is_recurring BOOLEAN DEFAULT FALSE,
    recurring_frequency VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Redis Cache Design

#### 1. Session Management
```
Key Pattern: session:{user_id}
TTL: 7 days
Value: {
    "user_id": "uuid",
    "email": "user@example.com",
    "plan": "premium",
    "permissions": ["read", "write"],
    "last_activity": "timestamp"
}
```

#### 2. API Rate Limiting
```
Key Pattern: rate_limit:{ip_address}:{endpoint}
TTL: 1 hour
Value: {
    "count": 100,
    "window_start": "timestamp",
    "limit": 1000
}
```

#### 3. Cache for Frequently Accessed Data
```
Key Pattern: cache:{data_type}:{id}
TTL: 1 hour
Value: JSON data
```

---

## 🔒 تصميم الأمان

### 1. Authentication & Authorization

#### JWT Token Structure
```json
{
    "header": {
        "alg": "RS256",
        "typ": "JWT"
    },
    "payload": {
        "sub": "user_id",
        "email": "user@example.com",
        "plan": "premium",
        "permissions": ["read", "write", "admin"],
        "iat": 1640995200,
        "exp": 1641600000,
        "jti": "token_id"
    }
}
```

#### Permission System
```go
type Permission string

const (
    PermissionReadInvoices    Permission = "invoices:read"
    PermissionWriteInvoices   Permission = "invoices:write"
    PermissionDeleteInvoices  Permission = "invoices:delete"
    PermissionReadCustomers   Permission = "customers:read"
    PermissionWriteCustomers  Permission = "customers:write"
    PermissionReadExpenses    Permission = "expenses:read"
    PermissionWriteExpenses   Permission = "expenses:write"
    PermissionAdminAccess     Permission = "admin:access"
)
```

### 2. Data Encryption

#### Encryption at Rest
- **Database**: AES-256 encryption for sensitive fields
- **File Storage**: S3 server-side encryption
- **Backups**: Encrypted backups with separate keys

#### Encryption in Transit
- **HTTPS**: TLS 1.3 for all communications
- **Database**: SSL/TLS connections
- **Internal Services**: mTLS for service-to-service communication

### 3. Security Headers
```go
func SecurityHeaders() gin.HandlerFunc {
    return func(c *gin.Context) {
        c.Header("X-Content-Type-Options", "nosniff")
        c.Header("X-Frame-Options", "DENY")
        c.Header("X-XSS-Protection", "1; mode=block")
        c.Header("Strict-Transport-Security", "max-age=31536000; includeSubDomains")
        c.Header("Content-Security-Policy", "default-src 'self'")
        c.Header("Referrer-Policy", "strict-origin-when-cross-origin")
        c.Next()
    }
}
```

---

## 📊 تصميم المراقبة والمراقبة

### 1. Metrics Collection

#### Application Metrics
```go
type Metrics struct {
    HTTPRequestsTotal    prometheus.CounterVec
    HTTPRequestDuration  prometheus.HistogramVec
    ActiveConnections    prometheus.Gauge
    DatabaseConnections  prometheus.Gauge
    CacheHitRate         prometheus.Gauge
    ErrorRate            prometheus.CounterVec
}
```

#### Business Metrics
```go
type BusinessMetrics struct {
    InvoicesCreated      prometheus.Counter
    InvoicesPaid         prometheus.Counter
    OCRScansProcessed    prometheus.Counter
    OCRAccuracy          prometheus.Gauge
    UserRegistrations    prometheus.Counter
    ActiveUsers          prometheus.Gauge
}
```

### 2. Logging Strategy

#### Structured Logging
```go
type LogEntry struct {
    Timestamp   time.Time              `json:"timestamp"`
    Level       string                 `json:"level"`
    Service     string                 `json:"service"`
    Message     string                 `json:"message"`
    UserID      string                 `json:"user_id,omitempty"`
    RequestID   string                 `json:"request_id,omitempty"`
    Duration    int64                  `json:"duration_ms,omitempty"`
    Fields      map[string]interface{} `json:"fields,omitempty"`
}
```

### 3. Health Checks

#### Service Health Endpoints
```go
type HealthStatus struct {
    Status    string            `json:"status"`
    Timestamp time.Time         `json:"timestamp"`
    Services  map[string]string `json:"services"`
    Version   string            `json:"version"`
    Uptime    string            `json:"uptime"`
}
```

---

## 🚀 تصميم النشر والتوسع

### 1. Container Strategy

#### Dockerfile for Backend
```dockerfile
FROM golang:1.21-alpine AS builder

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o main cmd/main.go

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /app/main .
EXPOSE 8080
CMD ["./main"]
```

#### Dockerfile for Frontend
```dockerfile
FROM node:18-alpine AS builder

WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

### 2. Kubernetes Deployment

#### Backend Deployment
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: baseer-backend
spec:
  replicas: 3
  selector:
    matchLabels:
      app: baseer-backend
  template:
    metadata:
      labels:
        app: baseer-backend
    spec:
      containers:
      - name: backend
        image: baseer/backend:latest
        ports:
        - containerPort: 8080
        env:
        - name: DB_HOST
          valueFrom:
            secretKeyRef:
              name: db-secret
              key: host
        resources:
          requests:
            memory: "256Mi"
            cpu: "250m"
          limits:
            memory: "512Mi"
            cpu: "500m"
```

### 3. Auto-scaling Configuration
```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: baseer-backend-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: baseer-backend
  minReplicas: 3
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 70
  - type: Resource
    resource:
      name: memory
      target:
        type: Utilization
        averageUtilization: 80
```

---

## 📈 تصميم الأداء والتحسين

### 1. Database Optimization

#### Indexing Strategy
```sql
-- User queries optimization
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_subscription ON users(subscription_plan, subscription_status);

-- Invoice queries optimization
CREATE INDEX idx_invoices_user_date ON invoices(user_id, issue_date DESC);
CREATE INDEX idx_invoices_status ON invoices(status);
CREATE INDEX idx_invoices_due_date ON invoices(due_date) WHERE status IN ('sent', 'viewed');

-- Customer queries optimization
CREATE INDEX idx_customers_user ON customers(user_id);
CREATE INDEX idx_customers_name ON customers(name);

-- Expense queries optimization
CREATE INDEX idx_expenses_user_date ON expenses(user_id, expense_date DESC);
CREATE INDEX idx_expenses_category ON expenses(category);
```

#### Query Optimization
```sql
-- Optimized invoice listing query
SELECT 
    i.id,
    i.invoice_number,
    i.total_amount,
    i.status,
    i.issue_date,
    c.name as customer_name
FROM invoices i
JOIN customers c ON i.customer_id = c.id
WHERE i.user_id = $1
ORDER BY i.issue_date DESC
LIMIT $2 OFFSET $3;
```

### 2. Caching Strategy

#### Application-Level Caching
```go
type CacheManager struct {
    redis  *redis.Client
    local  *cache.Cache
    config CacheConfig
}

func (cm *CacheManager) Get(key string) (interface{}, error) {
    // Try local cache first
    if value, found := cm.local.Get(key); found {
        return value, nil
    }
    
    // Try Redis cache
    value, err := cm.redis.Get(context.Background(), key).Result()
    if err == nil {
        cm.local.Set(key, value, cm.config.LocalTTL)
        return value, nil
    }
    
    return nil, err
}
```

### 3. API Optimization

#### Response Compression
```go
func CompressionMiddleware() gin.HandlerFunc {
    return gin.HandlerFunc(func(c *gin.Context) {
        if strings.Contains(c.GetHeader("Accept-Encoding"), "gzip") {
            c.Header("Content-Encoding", "gzip")
            c.Header("Vary", "Accept-Encoding")
            
            gz := gzip.NewWriter(c.Writer)
            defer gz.Close()
            
            c.Writer = &gzipWriter{c.Writer, gz}
        }
        c.Next()
    })
}
```

---

## 🔄 تصميم التكامل والاتصال

### 1. API Gateway Configuration

#### Rate Limiting
```go
type RateLimiter struct {
    redis  *redis.Client
    config RateLimitConfig
}

func (rl *RateLimiter) Allow(key string) (bool, error) {
    script := `
        local key = KEYS[1]
        local limit = tonumber(ARGV[1])
        local window = tonumber(ARGV[2])
        local current = redis.call('GET', key)
        
        if current == false then
            redis.call('SET', key, 1)
            redis.call('EXPIRE', key, window)
            return 1
        end
        
        if tonumber(current) < limit then
            return redis.call('INCR', key)
        else
            return 0
        end
    `
    
    result, err := rl.redis.Eval(context.Background(), script, []string{key}, rl.config.Limit, rl.config.Window).Result()
    return result.(int64) > 0, err
}
```

### 2. Service Communication

#### Event-Driven Architecture
```go
type Event struct {
    ID        string                 `json:"id"`
    Type      string                 `json:"type"`
    Source    string                 `json:"source"`
    Data      map[string]interface{} `json:"data"`
    Timestamp time.Time              `json:"timestamp"`
    Version   string                 `json:"version"`
}

type EventBus interface {
    Publish(ctx context.Context, event Event) error
    Subscribe(ctx context.Context, eventType string, handler EventHandler) error
}
```

### 3. External Integrations

#### ZATCA Integration
```go
type ZATCAClient struct {
    baseURL    string
    apiKey     string
    httpClient *http.Client
}

func (z *ZATCAClient) SubmitInvoice(invoice *Invoice) (*ZATCAResponse, error) {
    xmlData := z.generateXML(invoice)
    hash := z.generateHash(xmlData)
    
    payload := ZATCAPayload{
        InvoiceHash: hash,
        InvoiceXML:  xmlData,
        UUID:        invoice.ZATCAUUID,
    }
    
    return z.submitToZATCA(payload)
}
```

---

## 📋 ملخص التصميم المعماري

### المبادئ الأساسية
1. **Scalability**: قابلية التوسع الأفقي والعمودي
2. **Reliability**: موثوقية عالية مع استرداد سريع
3. **Security**: أمان شامل على جميع المستويات
4. **Performance**: أداء عالي مع استجابة سريعة
5. **Maintainability**: سهولة الصيانة والتطوير
6. **Observability**: مراقبة شاملة للأداء والصحة

### التقنيات المختارة
- **Frontend**: Flutter 3.16.0 + Riverpod
- **Backend**: Go 1.21 + Gin Framework
- **Database**: PostgreSQL 15 + Redis 7.2
- **Infrastructure**: AWS + Kubernetes
- **Monitoring**: Prometheus + Grafana
- **Security**: JWT + TLS 1.3 + Encryption

### مؤشرات النجاح
- **Response Time**: < 100ms للـ API
- **Uptime**: 99.9%+ availability
- **Scalability**: دعم 100K+ مستخدم متزامن
- **Security**: Zero security incidents
- **Performance**: < 3s app launch time

---

**هذا التصميم المعماري يضمن بناء نظام قوي، قابل للتوسع، وآمن للمنطقة العربية.** 🚀
