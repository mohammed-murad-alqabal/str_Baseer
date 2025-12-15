# MVP Execution Plan - Baseer Critical Path

## Mission Statement
**Enable a Saudi freelancer to issue a ZATCA-compliant e-invoice in the fastest possible time.**

## Strategic Focus
This plan represents the absolute minimum viable product that delivers immediate value to our target user: a Saudi freelancer who needs ZATCA compliance TODAY. Every task directly serves this singular goal.

## Critical Path Tasks (5 Core Tasks)

### Task 1: Foundation & Infrastructure (Week 1)
**Goal**: Get the basic system running and accessible

- [ ] 1.1 Set up project foundation and development environment
  - Create Go backend with Gin framework
  - Create Flutter web application (web-only for MVP)
  - Set up GitHub repository with basic CI/CD
  - Configure local development environment
  - _Requirements: Development foundation for all subsequent tasks_

- [ ] 1.2 Deploy minimal infrastructure
  - Deploy core AWS infrastructure: VPC, single EC2 instance, RDS PostgreSQL
  - Skip EKS, Redis, and complex monitoring for MVP
  - Set up basic SSL and domain
  - _Requirements: 9.1, 9.2 (minimal implementation)_

### Task 2: Core Authentication & User Setup (Week 1-2)
**Goal**: Allow users to register and access the system

- [ ] 2.1 Implement basic authentication system
  - JWT authentication (no MFA for MVP)
  - User registration with email verification
  - Simple login/logout functionality
  - Basic user profile with business name and tax number
  - _Requirements: 1.1, 1.2, 1.3, 1.6 (essential fields only)_

- [ ] 2.2 Create minimal database schema
  - Users and user_profiles tables
  - Invoices and invoice_items tables
  - Skip customers table (inline customer data in invoices for MVP)
  - _Requirements: 1.1, 2.1, 2.3_

### Task 3: ZATCA Integration (Week 2-3)
**Goal**: Achieve ZATCA compliance - the core value proposition

- [ ] 3.1 Research and implement ZATCA API integration
  - Study ZATCA Phase 2 API documentation
  - Create ZATCA client with certificate authentication
  - Implement invoice validation according to ZATCA rules
  - Build QR code generation for invoices
  - _Requirements: 2.4, 2.5, 2.7_

- [ ] 3.2 Implement Saudi VAT calculation
  - Hard-code Saudi VAT rates (15%)
  - Create invoice number generation following ZATCA format
  - Implement basic digital signature for invoices
  - _Requirements: 2.2, 2.3_

### Task 4: Basic Invoice Creation (Week 3-4)
**Goal**: Enable users to create and submit invoices

- [ ] 4.1 Build core invoice functionality
  - Simple invoice creation form (web-only)
  - Inline customer information (no separate customer management)
  - Basic invoice templates (standard invoice only)
  - Invoice status: draft, submitted, approved
  - _Requirements: 2.1, 2.7_

- [ ] 4.2 Create invoice PDF generation
  - Generate PDF with Arabic support
  - Embed ZATCA QR code in PDF
  - Basic invoice layout (no customization)
  - _Requirements: 2.7, 7.3_

### Task 5: ZATCA Submission & Basic UI (Week 4-5)
**Goal**: Complete the end-to-end flow

- [ ] 5.1 Complete ZATCA submission workflow
  - Connect invoice creation with ZATCA validation
  - Implement automatic ZATCA submission
  - Handle ZATCA responses and update invoice status
  - Display success/error messages to user
  - _Requirements: 2.4, 2.5, 2.6_

- [ ] 5.2 Build minimal Flutter web interface
  - Login/registration screens
  - Simple invoice creation form
  - Basic invoice list view
  - Invoice PDF download
  - Arabic RTL support (basic)
  - _Requirements: 6.1, 7.1, 7.2_

## What We're NOT Building in MVP

### Deferred Features (Post-MVP)
- **Customer Management System**: Use inline customer data in invoices
- **Payment Processing**: Focus on invoice creation, not payment collection
- **Advanced Reporting**: Basic invoice list is sufficient
- **Mobile App**: Web-only for MVP speed
- **OCR Features**: Manual data entry only
- **MFA/Advanced Security**: Basic JWT authentication sufficient
- **Multiple Payment Gateways**: No payment processing in MVP
- **Advanced Arabic Features**: Basic RTL support only
- **API Documentation**: Internal use only for MVP
- **Comprehensive Monitoring**: Basic error logging sufficient
- **Multiple Invoice Types**: Standard invoices only
- **Email/WhatsApp Integration**: PDF download only

### Technical Simplifications
- **Single Server Deployment**: No Kubernetes complexity
- **No Redis Caching**: Direct database queries
- **Minimal Error Handling**: Basic validation only
- **No Advanced Testing**: Manual testing for MVP
- **Basic Styling**: Functional UI, not polished design

## Success Criteria for MVP

### Technical Milestones
- [ ] User can register and login
- [ ] User can create a basic invoice with customer details
- [ ] Invoice is validated and submitted to ZATCA successfully
- [ ] User receives ZATCA-compliant PDF with QR code
- [ ] System handles ZATCA errors gracefully

### Business Validation
- [ ] 10 beta users can complete the full invoice flow
- [ ] 100% ZATCA compliance rate for submitted invoices
- [ ] Average invoice creation time < 5 minutes
- [ ] Zero critical bugs in core flow

## Timeline: 5 Weeks to Live MVP

**Week 1**: Foundation + Authentication
**Week 2**: ZATCA Integration Research + Database
**Week 3**: ZATCA Implementation + Basic Invoice Creation
**Week 4**: PDF Generation + Invoice Management
**Week 5**: Frontend Polish + Beta Testing

## Resource Requirements

### Team (3 People Maximum)
- 1 Senior Go Developer (Backend + ZATCA integration)
- 1 Flutter Developer (Web frontend)
- 1 Product Manager/QA (Testing + User feedback)

### Infrastructure Costs
- AWS EC2 + RDS: ~$200/month
- Domain + SSL: ~$50/month
- ZATCA API access: Free (sandbox)

## Risk Mitigation

### Critical Risks
1. **ZATCA API Complexity**: Build simulator for testing, start integration early
2. **Arabic RTL Issues**: Use proven Flutter RTL packages
3. **PDF Generation**: Use established Go PDF libraries with Arabic support

### Contingency Plans
- If ZATCA integration takes longer: Build mock ZATCA service for demo
- If Flutter web has issues: Fall back to simple HTML/CSS frontend
- If PDF generation fails: Provide basic HTML invoice view

## Post-MVP Roadmap (Weeks 6-12)

Once MVP is validated with 10+ paying users:
1. Add customer management system
2. Implement payment gateway integration
3. Build mobile app
4. Add advanced reporting
5. Expand to other GCC countries

---

**This plan represents the absolute minimum to deliver value. Every task directly serves the goal of ZATCA-compliant invoice creation. No feature creep allowed.**