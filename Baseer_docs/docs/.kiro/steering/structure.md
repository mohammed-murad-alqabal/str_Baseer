# Project Structure - Baseer

## Repository Organization

This is a documentation-heavy repository containing comprehensive project specifications and infrastructure code for the Baseer financial platform.

## Current Structure

```
├── .kiro/                          # Kiro IDE configuration and steering rules
├── infrastructure/                 # Infrastructure as Code
│   └── terraform/                  # Terraform configurations for AWS
├── 06_UX_UI_Design_Package/       # Design system and user flows
├── _archive_20251011/              # Archived project iterations and analysis
├── 01_Vision_Document.md           # Project vision and strategic objectives
├── 02_Market_Analysis.md           # Market research and competitive analysis
├── 03_Feasibility_Study.md         # Technical and business feasibility
├── 04_Business_Requirements_Document.md  # Business requirements
├── 05_Product_Requirements_Document.md   # Product specifications
├── 07_Technical_Design_Document.md # System architecture and technical specs
└── 08_Test_Plan.md                # Testing strategy and procedures
```

## Document Dependencies

The documents follow a logical dependency chain:
1. **Vision Document** → Market Analysis → Feasibility Study
2. **Business Requirements** → Product Requirements → Technical Design
3. **UX/UI Design** references Product Requirements
4. **Infrastructure** implements Technical Design specifications

## Infrastructure Layout

### Terraform Structure
- `main.tf`: Complete AWS infrastructure definition
- `variables.tf`: Configurable parameters for different environments
- Includes: VPC, EKS, RDS, ElastiCache, S3, CloudFront, IAM roles

### Key Infrastructure Components
- **Networking**: VPC with public/private subnets across 3 AZs
- **Compute**: EKS cluster with managed node groups
- **Database**: PostgreSQL RDS with Multi-AZ deployment
- **Caching**: Redis ElastiCache cluster
- **Storage**: S3 buckets with CloudFront CDN
- **Security**: Security groups, IAM roles, Secrets Manager

## Design System Structure

### Design Package Contents
- `DesignSystem.json`: Complete design tokens and component specifications
- `UserFlows.md`: Detailed user journey mappings with Mermaid diagrams

### Design System Features
- Arabic-first design with RTL support
- Comprehensive color palette with semantic colors
- Typography system supporting Arabic (Noto Sans Arabic) and English (Inter)
- Component library with variants and states
- Accessibility guidelines (WCAG 2.1 AA compliance)

## Naming Conventions

### Files and Directories
- Use descriptive names in English for technical files
- Arabic content files use English filenames with Arabic content
- Infrastructure files follow Terraform best practices
- Design files use clear, descriptive names

### Code Standards (when implemented)
- **Go services**: `kebab-case` for packages, `camelCase` for functions
- **React components**: `PascalCase` for components, `camelCase` for props
- **Flutter widgets**: `PascalCase` for widgets, `camelCase` for methods
- **Database**: `snake_case` for tables and columns
- **APIs**: RESTful URLs with plural nouns (`/v1/invoices`, `/v1/customers`)

## Environment Structure (Future Implementation)

```
├── frontend/                       # React web application
│   ├── src/
│   │   ├── components/            # Reusable UI components
│   │   ├── pages/                 # Page components
│   │   ├── hooks/                 # Custom React hooks
│   │   ├── services/              # API service layer
│   │   └── utils/                 # Utility functions
├── mobile/                        # Flutter mobile application
│   ├── lib/
│   │   ├── screens/               # Screen widgets
│   │   ├── widgets/               # Reusable widgets
│   │   ├── services/              # API and local services
│   │   └── models/                # Data models
├── backend/                       # Go microservices
│   ├── services/
│   │   ├── user-service/          # User management
│   │   ├── invoice-service/       # Invoice operations
│   │   ├── customer-service/      # Customer management
│   │   └── payment-service/       # Payment processing
│   └── shared/                    # Shared libraries
└── docs/                          # API documentation and guides
```

## Configuration Management

### Environment-Specific Configs
- **Development**: Local development with Docker Compose
- **Staging**: AWS staging environment (current Terraform config)
- **Production**: Production AWS environment with enhanced security

### Secrets Management
- Database credentials in AWS Secrets Manager
- JWT secrets for authentication
- API keys for external services (ZATCA, payment gateways)
- All secrets referenced via environment variables

## Documentation Standards

### Technical Documentation
- All documents in Markdown format
- Mermaid diagrams for flowcharts and architecture
- YAML frontmatter for metadata
- Arabic content with English technical terms

### Code Documentation
- Go: Use godoc conventions
- React: JSDoc comments for complex functions
- Flutter: Dart documentation comments
- APIs: OpenAPI 3.0 specifications

## Archive Management

The `_archive_20251011/` directory contains:
- Previous project iterations
- Analysis documents and research
- Legacy design packages
- Historical decision records

Keep archived for reference but focus development on current specifications.