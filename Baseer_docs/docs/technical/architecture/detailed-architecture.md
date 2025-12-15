# 🏗️ التصاميم المعمارية التفصيلية - Baseer

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

## 🎯 نظرة عامة على التصاميم

### الهدف من التصاميم
توفير تصاميم معمارية مفصلة ودقيقة لجميع مكونات النظام، مع التركيز على القابلية للتوسع والأمان والأداء.

### المبادئ التصميمية
1. **Microservices Architecture**: خدمات منفصلة وقابلة للتوسع
2. **Domain-Driven Design**: تصميم مدفوع بالمجال
3. **Event-Driven Architecture**: معمارية مدفوعة بالأحداث
4. **API-First Design**: تصميم API أولاً
5. **Security by Design**: الأمان في التصميم
6. **Scalability**: قابلية التوسع الأفقي والعمودي

---

## 🏛️ التصميم المعماري العام

### 1. نظرة عامة على النظام
```
┌─────────────────────────────────────────────────────────────┐
│                    Baseer System Architecture              │
├─────────────────────────────────────────────────────────────┤
│  Frontend Layer (Flutter)                                   │
│  ├── Mobile App (iOS/Android)                              │
│  └── Web Dashboard (React)                                 │
├─────────────────────────────────────────────────────────────┤
│  API Gateway Layer                                          │
│  ├── Authentication & Authorization                         │
│  ├── Rate Limiting & Throttling                            │
│  ├── Request Routing & Load Balancing                      │
│  └── API Versioning & Documentation                         │
├─────────────────────────────────────────────────────────────┤
│  Microservices Layer                                       │
│  ├── Auth Service      ├── Invoice Service                 │
│  ├── User Service      ├── OCR Service                     │
│  ├── Customer Service  ├── Analytics Service               │
│  └── Payment Service   └── Notification Service            │
├─────────────────────────────────────────────────────────────┤
│  Data Layer                                                 │
│  ├── PostgreSQL (Primary Database)                         │
│  ├── Redis (Cache & Sessions)                              │
│  └── S3 (File Storage)                                     │
├─────────────────────────────────────────────────────────────┤
│  Infrastructure Layer                                       │
│  ├── AWS Services (EC2, RDS, ElastiCache, S3)              │
│  ├── Kubernetes (Container Orchestration)                  │
│  ├── Monitoring (Prometheus, Grafana)                       │
│  └── Logging (ELK Stack)                                   │
└─────────────────────────────────────────────────────────────┘
```

### 2. تدفق البيانات العام
```
User Request → API Gateway → Microservice → Database
     ↓              ↓            ↓           ↓
   Response ← API Gateway ← Microservice ← Database
```

---

## 🔧 تصميم الميكروسيرفيس

### 1. Auth Service (خدمة المصادقة)

#### المسؤوليات
- إدارة المستخدمين والمصادقة
- إصدار وإدارة JWT tokens
- إدارة الجلسات والأذونات
- المصادقة الثنائية

#### API Endpoints
```yaml
POST /auth/register
POST /auth/login
POST /auth/logout
POST /auth/refresh
POST /auth/forgot-password
POST /auth/reset-password
POST /auth/verify-email
POST /auth/2fa/enable
POST /auth/2fa/verify
GET  /auth/profile
PUT  /auth/profile
PUT  /auth/password
```

#### Database Schema
```sql
-- Users table
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
    two_factor_secret VARCHAR(255),
    last_login TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- User sessions table
CREATE TABLE user_sessions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id),
    token_hash VARCHAR(255) NOT NULL,
    device_info JSONB,
    ip_address INET,
    expires_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### Service Architecture
```go
type AuthService struct {
    userRepo    UserRepository
    sessionRepo SessionRepository
    jwtService  JWTService
    emailService EmailService
    smsService  SMSService
    logger      Logger
}

type UserRepository interface {
    Create(ctx context.Context, user *User) error
    GetByEmail(ctx context.Context, email string) (*User, error)
    GetByID(ctx context.Context, id string) (*User, error)
    Update(ctx context.Context, user *User) error
    Delete(ctx context.Context, id string) error
}
```

### 2. Invoice Service (خدمة الفواتير)

#### المسؤوليات
- إدارة الفواتير والفواتير الإلكترونية
- تكامل مع ZATCA
- إنشاء PDF و QR codes
- إدارة المدفوعات

#### API Endpoints
```yaml
GET    /invoices
POST   /invoices
GET    /invoices/{id}
PUT    /invoices/{id}
DELETE /invoices/{id}
POST   /invoices/{id}/send
POST   /invoices/{id}/pay
GET    /invoices/{id}/pdf
GET    /invoices/{id}/qr
POST   /invoices/{id}/zatca/submit
```

#### Database Schema
```sql
-- Invoices table
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

-- Invoice items table
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

#### Service Architecture
```go
type InvoiceService struct {
    invoiceRepo InvoiceRepository
    customerRepo CustomerRepository
    zatcaClient ZATCAClient
    pdfService PDFService
    qrService QRService
    emailService EmailService
    logger Logger
}

type InvoiceRepository interface {
    Create(ctx context.Context, invoice *Invoice) error
    GetByID(ctx context.Context, id string) (*Invoice, error)
    GetByUserID(ctx context.Context, userID string, pagination *Pagination) ([]*Invoice, error)
    Update(ctx context.Context, invoice *Invoice) error
    Delete(ctx context.Context, id string) error
    GetByStatus(ctx context.Context, status string) ([]*Invoice, error)
}
```

### 3. OCR Service (خدمة مسح الإيصالات)

#### المسؤوليات
- معالجة الصور والإيصالات
- تكامل مع Google Vision API
- استخلاص البيانات من النصوص العربية
- تحسين دقة OCR

#### API Endpoints
```yaml
POST /ocr/scan
POST /ocr/scan/batch
GET  /ocr/scan/{id}/status
GET  /ocr/scan/{id}/result
POST /ocr/scan/{id}/verify
GET  /ocr/templates
POST /ocr/templates
```

#### Service Architecture
```go
type OCRService struct {
    visionClient *vision.ImageAnnotatorClient
    imageProcessor ImageProcessor
    dataExtractor DataExtractor
    templateService TemplateService
    storageService StorageService
    logger Logger
}

type ImageProcessor interface {
    PreprocessImage(image []byte) ([]byte, error)
    EnhanceImage(image []byte) ([]byte, error)
    ExtractText(image []byte) (string, error)
}

type DataExtractor interface {
    ExtractInvoiceData(text string) (*InvoiceData, error)
    ExtractExpenseData(text string) (*ExpenseData, error)
    ValidateExtractedData(data interface{}) error
}
```

### 4. Analytics Service (خدمة التحليلات)

#### المسؤوليات
- جمع وتحليل البيانات المالية
- إنشاء التقارير والرسوم البيانية
- التحليلات التنبؤية
- مؤشرات الأداء الرئيسية

#### API Endpoints
```yaml
GET /analytics/dashboard
GET /analytics/revenue
GET /analytics/expenses
GET /analytics/customers
GET /analytics/invoices
GET /analytics/predictions
GET /analytics/reports
POST /analytics/reports/generate
```

#### Service Architecture
```go
type AnalyticsService struct {
    invoiceRepo InvoiceRepository
    expenseRepo ExpenseRepository
    customerRepo CustomerRepository
    reportGenerator ReportGenerator
    chartService ChartService
    predictionService PredictionService
    logger Logger
}

type ReportGenerator interface {
    GenerateRevenueReport(ctx context.Context, filters *ReportFilters) (*RevenueReport, error)
    GenerateExpenseReport(ctx context.Context, filters *ReportFilters) (*ExpenseReport, error)
    GenerateCustomerReport(ctx context.Context, filters *ReportFilters) (*CustomerReport, error)
}
```

---

## 🗄️ تصميم قاعدة البيانات

### 1. تصميم قاعدة البيانات الرئيسية

#### العلاقات الأساسية
```sql
-- Users (1) ←→ (N) Customers
-- Users (1) ←→ (N) Invoices
-- Users (1) ←→ (N) Expenses
-- Customers (1) ←→ (N) Invoices
-- Invoices (1) ←→ (N) Invoice Items
```

#### الفهارس المحسنة
```sql
-- User indexes
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_subscription ON users(subscription_plan, subscription_status);
CREATE INDEX idx_users_created_at ON users(created_at);

-- Invoice indexes
CREATE INDEX idx_invoices_user_date ON invoices(user_id, issue_date DESC);
CREATE INDEX idx_invoices_status ON invoices(status);
CREATE INDEX idx_invoices_due_date ON invoices(due_date) WHERE status IN ('sent', 'viewed');
CREATE INDEX idx_invoices_customer ON invoices(customer_id);

-- Customer indexes
CREATE INDEX idx_customers_user ON customers(user_id);
CREATE INDEX idx_customers_name ON customers(name);
CREATE INDEX idx_customers_email ON customers(email);

-- Expense indexes
CREATE INDEX idx_expenses_user_date ON expenses(user_id, expense_date DESC);
CREATE INDEX idx_expenses_category ON expenses(category);
CREATE INDEX idx_expenses_amount ON expenses(amount);
```

### 2. تصميم Redis Cache

#### استراتيجية التخزين المؤقت
```yaml
Cache Keys:
  - session:{user_id} - User sessions (TTL: 7 days)
  - user:{user_id} - User data (TTL: 1 hour)
  - invoice:{invoice_id} - Invoice data (TTL: 30 minutes)
  - customer:{customer_id} - Customer data (TTL: 1 hour)
  - analytics:{user_id}:{type} - Analytics data (TTL: 15 minutes)
  - rate_limit:{ip}:{endpoint} - Rate limiting (TTL: 1 hour)
```

#### Cache Implementation
```go
type CacheService struct {
    redis *redis.Client
    config CacheConfig
}

type CacheConfig struct {
    DefaultTTL time.Duration
    UserTTL    time.Duration
    InvoiceTTL time.Duration
    AnalyticsTTL time.Duration
}

func (c *CacheService) Get(key string) (interface{}, error) {
    result, err := c.redis.Get(context.Background(), key).Result()
    if err != nil {
        return nil, err
    }
    
    var data interface{}
    err = json.Unmarshal([]byte(result), &data)
    return data, err
}

func (c *CacheService) Set(key string, value interface{}, ttl time.Duration) error {
    data, err := json.Marshal(value)
    if err != nil {
        return err
    }
    
    return c.redis.Set(context.Background(), key, data, ttl).Err()
}
```

---

## 🔒 تصميم الأمان

### 1. تصميم المصادقة والتفويض

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
    "permissions": ["invoices:read", "invoices:write", "customers:read"],
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
    // Invoice permissions
    PermissionReadInvoices    Permission = "invoices:read"
    PermissionWriteInvoices   Permission = "invoices:write"
    PermissionDeleteInvoices  Permission = "invoices:delete"
    
    // Customer permissions
    PermissionReadCustomers   Permission = "customers:read"
    PermissionWriteCustomers  Permission = "customers:write"
    PermissionDeleteCustomers Permission = "customers:delete"
    
    // Expense permissions
    PermissionReadExpenses    Permission = "expenses:read"
    PermissionWriteExpenses   Permission = "expenses:write"
    PermissionDeleteExpenses  Permission = "expenses:delete"
    
    // Admin permissions
    PermissionAdminAccess     Permission = "admin:access"
    PermissionSystemConfig    Permission = "system:config"
)

type Role struct {
    ID          string       `json:"id"`
    Name        string       `json:"name"`
    Permissions []Permission `json:"permissions"`
}

var Roles = map[string]Role{
    "free": {
        ID:   "free",
        Name: "Free User",
        Permissions: []Permission{
            PermissionReadInvoices,
            PermissionWriteInvoices,
            PermissionReadCustomers,
            PermissionWriteCustomers,
            PermissionReadExpenses,
            PermissionWriteExpenses,
        },
    },
    "premium": {
        ID:   "premium",
        Name: "Premium User",
        Permissions: []Permission{
            PermissionReadInvoices,
            PermissionWriteInvoices,
            PermissionDeleteInvoices,
            PermissionReadCustomers,
            PermissionWriteCustomers,
            PermissionDeleteCustomers,
            PermissionReadExpenses,
            PermissionWriteExpenses,
            PermissionDeleteExpenses,
        },
    },
    "admin": {
        ID:   "admin",
        Name: "Administrator",
        Permissions: []Permission{
            PermissionAdminAccess,
            PermissionSystemConfig,
        },
    },
}
```

### 2. تصميم التشفير

#### Encryption at Rest
```go
type EncryptionService struct {
    keyManager KeyManager
    cipher     cipher.AEAD
}

type KeyManager interface {
    GetKey(keyID string) ([]byte, error)
    RotateKey(keyID string) error
    CreateKey(keyID string) error
}

func (e *EncryptionService) Encrypt(data []byte, keyID string) ([]byte, error) {
    key, err := e.keyManager.GetKey(keyID)
    if err != nil {
        return nil, err
    }
    
    nonce := make([]byte, 12)
    if _, err := rand.Read(nonce); err != nil {
        return nil, err
    }
    
    ciphertext := e.cipher.Seal(nonce, nonce, data, nil)
    return ciphertext, nil
}

func (e *EncryptionService) Decrypt(data []byte, keyID string) ([]byte, error) {
    key, err := e.keyManager.GetKey(keyID)
    if err != nil {
        return nil, err
    }
    
    nonce := data[:12]
    ciphertext := data[12:]
    
    plaintext, err := e.cipher.Open(nil, nonce, ciphertext, nil)
    if err != nil {
        return nil, err
    }
    
    return plaintext, nil
}
```

#### Encryption in Transit
```go
type TLSService struct {
    config *tls.Config
}

func NewTLSService() *TLSService {
    return &TLSService{
        config: &tls.Config{
            MinVersion: tls.VersionTLS13,
            CipherSuites: []uint16{
                tls.TLS_AES_256_GCM_SHA384,
                tls.TLS_CHACHA20_POLY1305_SHA256,
                tls.TLS_AES_128_GCM_SHA256,
            },
            CurvePreferences: []tls.CurveID{
                tls.X25519,
                tls.CurveP256,
                tls.CurveP384,
            },
        },
    }
}
```

---

## 📊 تصميم المراقبة

### 1. تصميم جمع المقاييس

#### Application Metrics
```go
type Metrics struct {
    HTTPRequestsTotal    *prometheus.CounterVec
    HTTPRequestDuration  *prometheus.HistogramVec
    ActiveConnections    prometheus.Gauge
    DatabaseConnections  prometheus.Gauge
    CacheHitRate         prometheus.Gauge
    ErrorRate            *prometheus.CounterVec
}

func NewMetrics() *Metrics {
    return &Metrics{
        HTTPRequestsTotal: prometheus.NewCounterVec(
            prometheus.CounterOpts{
                Name: "http_requests_total",
                Help: "Total number of HTTP requests",
            },
            []string{"method", "endpoint", "status"},
        ),
        HTTPRequestDuration: prometheus.NewHistogramVec(
            prometheus.HistogramOpts{
                Name: "http_request_duration_seconds",
                Help: "HTTP request duration in seconds",
                Buckets: prometheus.DefBuckets,
            },
            []string{"method", "endpoint"},
        ),
        ActiveConnections: prometheus.NewGauge(
            prometheus.GaugeOpts{
                Name: "active_connections",
                Help: "Number of active connections",
            },
        ),
        DatabaseConnections: prometheus.NewGauge(
            prometheus.GaugeOpts{
                Name: "database_connections",
                Help: "Number of database connections",
            },
        ),
        CacheHitRate: prometheus.NewGauge(
            prometheus.GaugeOpts{
                Name: "cache_hit_rate",
                Help: "Cache hit rate percentage",
            },
        ),
        ErrorRate: prometheus.NewCounterVec(
            prometheus.CounterOpts{
                Name: "error_rate_total",
                Help: "Total number of errors",
            },
            []string{"service", "error_type"},
        ),
    }
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
    RevenueGenerated     prometheus.Counter
}

func NewBusinessMetrics() *BusinessMetrics {
    return &BusinessMetrics{
        InvoicesCreated: prometheus.NewCounter(
            prometheus.CounterOpts{
                Name: "invoices_created_total",
                Help: "Total number of invoices created",
            },
        ),
        InvoicesPaid: prometheus.NewCounter(
            prometheus.CounterOpts{
                Name: "invoices_paid_total",
                Help: "Total number of invoices paid",
            },
        ),
        OCRScansProcessed: prometheus.NewCounter(
            prometheus.CounterOpts{
                Name: "ocr_scans_processed_total",
                Help: "Total number of OCR scans processed",
            },
        ),
        OCRAccuracy: prometheus.NewGauge(
            prometheus.GaugeOpts{
                Name: "ocr_accuracy_percentage",
                Help: "OCR accuracy percentage",
            },
        ),
        UserRegistrations: prometheus.NewCounter(
            prometheus.CounterOpts{
                Name: "user_registrations_total",
                Help: "Total number of user registrations",
            },
        ),
        ActiveUsers: prometheus.NewGauge(
            prometheus.GaugeOpts{
                Name: "active_users_total",
                Help: "Total number of active users",
            },
        ),
        RevenueGenerated: prometheus.NewCounter(
            prometheus.CounterOpts{
                Name: "revenue_generated_total",
                Help: "Total revenue generated",
            },
        ),
    }
}
```

### 2. تصميم السجلات

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

type Logger struct {
    logger *logrus.Logger
    config LoggerConfig
}

type LoggerConfig struct {
    Level      string
    Format     string
    Output     string
    Service    string
    Version    string
}

func NewLogger(config LoggerConfig) *Logger {
    logger := logrus.New()
    
    level, err := logrus.ParseLevel(config.Level)
    if err != nil {
        level = logrus.InfoLevel
    }
    logger.SetLevel(level)
    
    if config.Format == "json" {
        logger.SetFormatter(&logrus.JSONFormatter{
            TimestampFormat: time.RFC3339,
        })
    } else {
        logger.SetFormatter(&logrus.TextFormatter{
            TimestampFormat: time.RFC3339,
        })
    }
    
    return &Logger{
        logger: logger,
        config: config,
    }
}

func (l *Logger) Info(ctx context.Context, message string, fields map[string]interface{}) {
    entry := l.logger.WithContext(ctx).WithFields(fields)
    entry.WithField("service", l.config.Service).Info(message)
}

func (l *Logger) Error(ctx context.Context, message string, err error, fields map[string]interface{}) {
    fields["error"] = err.Error()
    entry := l.logger.WithContext(ctx).WithFields(fields)
    entry.WithField("service", l.config.Service).Error(message)
}
```

---

## 🚀 تصميم النشر

### 1. تصميم Kubernetes

#### Backend Deployment
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: baseer-backend
  labels:
    app: baseer-backend
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
        - name: DB_PASSWORD
          valueFrom:
            secretKeyRef:
              name: db-secret
              key: password
        - name: REDIS_HOST
          valueFrom:
            secretKeyRef:
              name: redis-secret
              key: host
        - name: REDIS_PASSWORD
          valueFrom:
            secretKeyRef:
              name: redis-secret
              key: password
        resources:
          requests:
            memory: "256Mi"
            cpu: "250m"
          limits:
            memory: "512Mi"
            cpu: "500m"
        livenessProbe:
          httpGet:
            path: /health
            port: 8080
          initialDelaySeconds: 30
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /ready
            port: 8080
          initialDelaySeconds: 5
          periodSeconds: 5
```

#### Service Configuration
```yaml
apiVersion: v1
kind: Service
metadata:
  name: baseer-backend-service
spec:
  selector:
    app: baseer-backend
  ports:
  - protocol: TCP
    port: 80
    targetPort: 8080
  type: ClusterIP
```

#### Ingress Configuration
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: baseer-ingress
  annotations:
    kubernetes.io/ingress.class: nginx
    cert-manager.io/cluster-issuer: letsencrypt-prod
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
    nginx.ingress.kubernetes.io/rate-limit: "100"
spec:
  tls:
  - hosts:
    - api.baseer.app
    secretName: baseer-tls
  rules:
  - host: api.baseer.app
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: baseer-backend-service
            port:
              number: 80
```

### 2. تصميم Auto-scaling

#### Horizontal Pod Autoscaler
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
  maxReplicas: 20
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
  - type: Pods
    pods:
      metric:
        name: http_requests_per_second
      target:
        type: AverageValue
        averageValue: "100"
```

#### Vertical Pod Autoscaler
```yaml
apiVersion: autoscaling.k8s.io/v1
kind: VerticalPodAutoscaler
metadata:
  name: baseer-backend-vpa
spec:
  targetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: baseer-backend
  updatePolicy:
    updateMode: "Auto"
  resourcePolicy:
    containerPolicies:
    - containerName: backend
      minAllowed:
        cpu: 100m
        memory: 128Mi
      maxAllowed:
        cpu: 1000m
        memory: 1Gi
```

---

## 📈 تصميم الأداء

### 1. تصميم تحسين قاعدة البيانات

#### Query Optimization
```sql
-- Optimized invoice listing query
EXPLAIN (ANALYZE, BUFFERS) 
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
  AND i.issue_date >= $2
  AND i.issue_date <= $3
ORDER BY i.issue_date DESC
LIMIT $4 OFFSET $5;

-- Optimized customer search query
EXPLAIN (ANALYZE, BUFFERS)
SELECT 
    id,
    name,
    email,
    phone
FROM customers
WHERE user_id = $1
  AND (
    name ILIKE '%' || $2 || '%'
    OR email ILIKE '%' || $2 || '%'
    OR phone ILIKE '%' || $2 || '%'
  )
ORDER BY name
LIMIT $3;
```

#### Connection Pooling
```go
type DatabaseConfig struct {
    Host            string
    Port            int
    Database        string
    Username        string
    Password        string
    MaxOpenConns    int
    MaxIdleConns    int
    ConnMaxLifetime time.Duration
    ConnMaxIdleTime time.Duration
}

func NewDatabase(config DatabaseConfig) (*sql.DB, error) {
    dsn := fmt.Sprintf("host=%s port=%d dbname=%s user=%s password=%s sslmode=require",
        config.Host, config.Port, config.Database, config.Username, config.Password)
    
    db, err := sql.Open("postgres", dsn)
    if err != nil {
        return nil, err
    }
    
    db.SetMaxOpenConns(config.MaxOpenConns)
    db.SetMaxIdleConns(config.MaxIdleConns)
    db.SetConnMaxLifetime(config.ConnMaxLifetime)
    db.SetConnMaxIdleTime(config.ConnMaxIdleTime)
    
    return db, nil
}
```

### 2. تصميم تحسين التخزين المؤقت

#### Multi-level Caching
```go
type CacheManager struct {
    l1Cache *cache.Cache
    l2Cache *redis.Client
    config  CacheConfig
}

type CacheConfig struct {
    L1TTL time.Duration
    L2TTL time.Duration
}

func (cm *CacheManager) Get(key string) (interface{}, error) {
    // Try L1 cache first
    if value, found := cm.l1Cache.Get(key); found {
        return value, nil
    }
    
    // Try L2 cache
    value, err := cm.l2Cache.Get(context.Background(), key).Result()
    if err == nil {
        cm.l1Cache.Set(key, value, cm.config.L1TTL)
        return value, nil
    }
    
    return nil, err
}

func (cm *CacheManager) Set(key string, value interface{}) error {
    // Set in both caches
    cm.l1Cache.Set(key, value, cm.config.L1TTL)
    
    data, err := json.Marshal(value)
    if err != nil {
        return err
    }
    
    return cm.l2Cache.Set(context.Background(), key, data, cm.config.L2TTL).Err()
}
```

---

## 📋 ملخص التصاميم المعمارية

### المكونات الرئيسية
1. **Microservices Architecture**: خدمات منفصلة وقابلة للتوسع
2. **Clean Architecture**: فصل واضح بين الطبقات
3. **Event-Driven Design**: معمارية مدفوعة بالأحداث
4. **Security by Design**: أمان مدمج في كل مرحلة
5. **Performance Optimization**: أداء محسن من البداية

### التقنيات المختارة
- **Backend**: Go 1.21 + Gin Framework
- **Frontend**: Flutter 3.16.0 + Riverpod
- **Database**: PostgreSQL 15 + Redis 7.2
- **Infrastructure**: AWS + Kubernetes
- **Monitoring**: Prometheus + Grafana
- **Security**: JWT + TLS 1.3 + Encryption

### مؤشرات النجاح
- **Scalability**: دعم 100K+ مستخدم متزامن
- **Performance**: < 100ms API response
- **Security**: Zero security incidents
- **Reliability**: 99.9%+ uptime
- **Maintainability**: Clean code architecture

---

**هذه التصاميم المعمارية تضمن بناء نظام قوي، قابل للتوسع، وآمن للمنطقة العربية.** 🚀
