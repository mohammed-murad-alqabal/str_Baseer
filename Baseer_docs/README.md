# 🚀 Baseer - Intelligent Financial Operating System

<div align="center">

**"رؤيتك المالية، بلمسة ذكاء"**

[![Flutter](https://img.shields.io/badge/Flutter-3.16.0-blue.svg)](https://flutter.dev/)
[![Node.js](https://img.shields.io/badge/Node.js-18.x-green.svg)](https://nodejs.org/)
[![MongoDB](https://img.shields.io/badge/MongoDB-7.0-green.svg)](https://mongodb.com/)
[![License](https://img.shields.io/badge/License-Proprietary-red.svg)](LICENSE)

</div>

## 🎯 Overview

This workspace contains the **Baseer MVP** - the first intelligent financial operating system designed specifically for small businesses in Saudi Arabia. The system provides ZATCA-compliant electronic invoicing with intelligent expense tracking.

## 📁 Project Structure

```
.
├── baseer-mvp/                 # Main MVP application
│   ├── backend/               # Node.js API server
│   ├── frontend/              # Flutter mobile app
│   ├── database/              # MongoDB schemas and migrations
│   ├── infrastructure/        # AWS deployment configs
│   ├── scripts/               # Automation scripts
│   └── docs/                  # Project documentation
├── .kiro/                     # Kiro IDE configuration
│   ├── specs/                 # Feature specifications
│   ├── steering/              # Development guidelines
│   └── archive/               # Archived materials
└── README.md                  # This file
```

## 🚀 Quick Start

### Prerequisites

- Node.js 18.x or higher
- Flutter 3.16.0 or higher
- MongoDB 7.0 or higher
- AWS CLI configured

### Setup

```bash
# 1. Navigate to the MVP project
cd baseer-mvp

# 2. Run setup script
./scripts/setup/setup-dev.sh

# 3. Start development servers
./scripts/setup/start-dev.sh
```

## 🎯 Core Features

- ⚡ **ZATCA-Compliant Invoicing** - Automatic electronic invoice generation
- 📸 **Smart Receipt Scanning** - OCR for Arabic text with 90%+ accuracy
- 📊 **Real-time Dashboard** - Sales, expenses, and profit tracking
- 👥 **Customer Management** - Complete transaction history
- 🔒 **Bank-Grade Security** - AES-256 encryption and secure authentication

## 📚 Documentation

- 📖 [User Guide](baseer-mvp/docs/user-guide/README.md)
- 🔧 [Developer Guide](baseer-mvp/docs/developer/README.md)
- 🚀 [Deployment Guide](baseer-mvp/docs/deployment/README.md)
- 📊 [API Documentation](baseer-mvp/docs/api/README.md)

## 🛠️ Development

### Working with Specs

Feature development follows a spec-driven approach:

1. **Requirements** - User stories and acceptance criteria
2. **Design** - Technical architecture and implementation plan
3. **Tasks** - Actionable development checklist

Current specs are located in `.kiro/specs/` directory.

### Development Guidelines

- Follow the guidelines in `.kiro/steering/` for consistent development
- Use the project structure defined in `baseer-mvp/project-structure.md`
- Maintain code quality standards as defined in tech guidelines

## 📞 Support

- 📧 **Email:** support@baseer.app
- 🐛 **Issues:** Use GitHub Issues for bug reports
- 📱 **WhatsApp:** +966-XX-XXX-XXXX

## 📄 License

This project is proprietary software. All rights reserved to Baseer Financial Technologies.

---

<div align="center">

**Made with ❤️ in Saudi Arabia**

[Official Website](https://baseer.app) • [Documentation](https://docs.baseer.app)

</div>
