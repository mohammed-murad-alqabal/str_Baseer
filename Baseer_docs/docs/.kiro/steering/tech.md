# Technology Stack - Baseer

## Architecture

**Style**: Microservices with API-First approach
**Deployment**: Cloud-Native on AWS (Middle East - Bahrain region)
**Orchestration**: Kubernetes (AWS EKS)

## Tech Stack

### Frontend
- **Web**: React 18+ with Redux Toolkit, Material-UI v5 (Arabic customized)
- **Mobile**: Flutter 3.x with Riverpod state management
- **Build Tools**: Vite (web), Flutter SDK (mobile)
- **Styling**: Emotion + CSS-in-JS with RTL support

### Backend
- **Core Services**: Go 1.21+ with Gin Web Framework
- **Data Processing**: Python 3.11+ with FastAPI for ML/OCR services
- **API Design**: OpenAPI 3.0 specification, RESTful with JWT authentication

### Database & Storage
- **Primary DB**: PostgreSQL 15+ (AWS RDS Multi-AZ)
- **Caching**: Redis 7+ (AWS ElastiCache)
- **Search**: Elasticsearch 8+ (AWS OpenSearch)
- **File Storage**: AWS S3 with CloudFront CDN

### Infrastructure
- **Container Platform**: Docker + Kubernetes (AWS EKS)
- **CI/CD**: GitHub Actions with blue-green deployment
- **Monitoring**: Prometheus + Grafana, ELK Stack for logging
- **Security**: AWS Secrets Manager, Certificate Manager

## Key Integrations

- **ZATCA API**: Certificate-based authentication for e-invoicing compliance
- **Payment Gateways**: Moyasar, PayTabs (Mada, Credit Cards, Apple Pay)
- **OCR Services**: AWS Textract + custom models for receipt scanning
- **SMS/Email**: For OTP and notifications

## Development Commands

### Local Development
```bash
# Start development environment
docker-compose up -d

# Run web frontend
cd frontend && npm run dev

# Run mobile app
cd mobile && flutter run

# Run backend services
cd backend && go run main.go
```

### Testing
```bash
# Run all tests
make test

# Frontend tests
npm test

# Backend tests  
go test ./...

# Integration tests
make test-integration
```

### Deployment
```bash
# Deploy to staging
make deploy-staging

# Deploy to production (requires approval)
make deploy-production

# Infrastructure changes
cd infrastructure/terraform && terraform apply
```

## Code Standards

- **Go**: Follow effective Go guidelines, use gofmt and golint
- **React**: Use TypeScript, functional components with hooks
- **Flutter**: Follow Dart style guide, use proper widget composition
- **API**: RESTful design, consistent error handling, proper HTTP status codes

## Performance Targets

- API response time: < 200ms (95th percentile)
- Page load time: < 2 seconds
- Mobile app startup: < 3 seconds
- Database queries: < 100ms (95th percentile)
- Uptime: 99.99%

## Security Requirements

- All data encrypted at rest (AES-256) and in transit (TLS 1.3)
- JWT tokens with 15-minute expiry, refresh tokens for 7 days
- MFA mandatory for all users
- Regular security scanning with Snyk and SonarQube
- ZATCA compliance with digital signatures and QR codes