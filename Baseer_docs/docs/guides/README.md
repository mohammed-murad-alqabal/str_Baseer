# Baseer MVP - Smart Financial Operating System
## نظام بصير التشغيلي المالي الذكي

### 🏗️ Project Structure - هيكل المشروع

This project follows engineering best practices with clear separation of concerns:

```
baseer-mvp/
├── src/                    # 💻 SOURCE CODE
│   ├── frontend/          # Flutter application
│   ├── backend/           # Go microservices
│   ├── infrastructure/    # Terraform & Kubernetes
│   └── shared/           # Common utilities & services
├── docs/                  # 📚 DOCUMENTATION
│   ├── business/         # Business requirements & analysis
│   ├── technical/        # Technical specifications
│   ├── design/          # UX/UI design system
│   ├── reports/         # Analysis & performance reports
│   ├── api/             # API documentation
│   └── guides/          # Development guides
├── config/               # ⚙️ CONFIGURATION
│   ├── development/     # Development environment
│   ├── staging/        # Staging configuration
│   ├── production/     # Production configuration
│   └── shared/         # Shared configurations
└── .project/            # 🛠️ PROJECT MANAGEMENT
    ├── kiro/           # Kiro IDE configuration
    ├── vscode/         # VS Code settings
    └── tools/          # Development tools & scripts
```

### 🚀 Quick Start

```bash
# Development
flutter run -d chrome

# Backend
cd src/backend && go run cmd/main.go

# Full stack
docker-compose -f docker-compose.dev.yml up
```

### 📖 Documentation

- **Business**: [Business Documents](docs/business/)
- **Technical**: [Technical Specs](docs/technical/)
- **API**: [API Documentation](docs/api/)
- **Guides**: [Development Guides](docs/guides/)

### 🔧 Development

All development files are accessible through symbolic links in the root directory for seamless workflow.

