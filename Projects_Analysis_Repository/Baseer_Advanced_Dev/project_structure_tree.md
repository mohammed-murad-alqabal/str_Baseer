# هيكل شجرة الملفات الكامل للمشروع

```
baseer-project/
├── .dart_tool/
│   ├── dartpad/
│   │   └── web_plugin_registrant.dart
│   ├── flutter_build/ (مغلق)
│   ├── package_config.json
│   ├── package_graph.json
│   └── version
├── .flutter-plugins-dependencies
├── .kiro/
│   └── specs/
│       ├── comprehensive-code-quality-fix/ (مغلق)
│       └── mobile-experience-enhancement/ (مغلق)
├── Makefile
├── PROJECT_ANALYSIS_REPORT.md
├── README.md
├── analysis_options.yaml
├── android/
│   ├── .gradle/ (مغلق)
│   ├── .kotlin/
│   │   └── sessions/
│   ├── app/
│   │   ├── build.gradle.kts
│   │   └── src/
│   │       ├── debug/
│   │       │   └── AndroidManifest.xml
│   │       ├── main/
│   │       │   ├── AndroidManifest.xml
│   │       │   ├── java/ (مغلق)
│   │       │   ├── kotlin/ (مغلق)
│   │       │   └── res/ (مغلق)
│   │       └── profile/
│   │           └── AndroidManifest.xml
│   ├── build.gradle.kts
│   ├── frontend_android.iml
│   ├── gradle/
│   │   └── wrapper/
│   │       ├── gradle-wrapper.jar
│   │       └── gradle-wrapper.properties
│   ├── gradle.properties
│   ├── gradlew
│   ├── gradlew.bat
│   ├── local.properties
│   ├── mobile_android.iml
│   └── settings.gradle.kts
├── assets/
│   ├── fonts/
│   │   ├── Amiri-Bold.ttf
│   │   ├── Amiri-Regular.ttf
│   │   ├── Cairo-Bold.ttf
│   │   ├── Cairo-Regular.ttf
│   │   ├── Inter-Bold.ttf
│   │   ├── Inter-Medium.ttf
│   │   ├── Inter-Regular.ttf
│   │   ├── NotoSansArabic-Bold.ttf
│   │   ├── NotoSansArabic-Medium.ttf
│   │   ├── NotoSansArabic-Regular.ttf
│   │   └── README.md
│   ├── icons/
│   ├── images/
│   └── translations/
│       ├── ar.json
│       └── en.json
├── backend/
│   ├── Dockerfile
│   ├── Makefile
│   ├── baseer-api
│   ├── baseer-api-minimal
│   ├── cmd/
│   │   └── main.go
│   ├── docs/
│   │   └── phase9_reporting_dashboard.md
│   ├── go.mod
│   ├── go.sum
│   ├── internal/
│   │   ├── api/
│   │   │   ├── handlers/
│   │   │   │   ├── auth.go
│   │   │   │   ├── customer.go
│   │   │   │   ├── dashboard.go
│   │   │   │   ├── financial_reporting.go
│   │   │   │   ├── invoice.go
│   │   │   │   ├── mfa.go
│   │   │   │   ├── payment.go
│   │   │   │   └── zatca.go
│   │   │   ├── middleware/
│   │   │   │   ├── auth.go
│   │   │   │   ├── cors.go
│   │   │   │   ├── error.go
│   │   │   │   └── logger.go
│   │   │   └── server.go
│   │   ├── config/
│   │   │   └── config.go
│   │   ├── database/
│   │   │   ├── database.go
│   │   │   ├── migrations.go
│   │   │   └── seeder.go
│   │   ├── models/
│   │   │   ├── audit.go
│   │   │   ├── company.go
│   │   │   ├── customer.go
│   │   │   ├── invoice.go
│   │   │   ├── notification.go
│   │   │   ├── payment.go
│   │   │   ├── user.go
│   │   │   ├── user_profile.go
│   │   │   └── zatca.go
│   │   ├── services/
│   │   │   ├── auth.go
│   │   │   ├── customer.go
│   │   │   ├── dashboard.go
│   │   │   ├── financial_reporting.go
│   │   │   ├── invoice.go
│   │   │   ├── mfa.go
│   │   │   ├── notification.go
│   │   │   ├── otp.go
│   │   │   ├── payment.go
│   │   │   ├── payment_analytics.go
│   │   │   ├── resilience.go
│   │   │   ├── zatca.go
│   │   │   ├── zatca_certificate_manager.go
│   │   │   ├── zatca_digital_signature.go
│   │   │   └── zatca_enhanced.go
│   │   └── utils/
│   │       └── crypto.go
│   └── migrations/
│       └── 001_initial_schema.sql
├── build/ (مغلق)
├── config/
│   ├── development/
│   │   └── docker-compose.dev.yml
│   ├── production/
│   │   ├── Makefile
│   │   └── docker-compose.yml
│   └── shared/
│       ├── .dart_tool/
│       │   ├── extension_discovery/
│       │   │   ├── README.md
│       │   │   └── vs_code.json
│       │   ├── package_config.json
│       │   ├── package_graph.json
│       │   └── version
│       ├── .flutter-plugins-dependencies
│       ├── analysis_options.yaml
│       ├── build/ (مغلق)
│       ├── pubspec.lock
│       └── pubspec.yaml
├── docker-compose.dev.yml
├── docker-compose.yml
├── infrastructure/
│   ├── kubernetes/
│   │   └── agent-orchestrator.yaml
│   ├── monitoring/
│   │   ├── README.md
│   │   ├── alert_rules.yml
│   │   ├── alertmanager.yml
│   │   ├── docker-compose.monitoring.yml
│   │   ├── grafana-dashboards/
│   │   │   └── baseer-overview.json
│   │   ├── prometheus.yml
│   │   └── setup-monitoring.sh
│   └── terraform/
│       ├── main.tf
│       ├── production/
│       │   ├── README.md
│       │   ├── deploy.sh
│       │   ├── iam.tf
│       │   ├── main.tf
│       │   ├── monitoring.tf
│       │   ├── outputs.tf
│       │   ├── security.tf
│       │   ├── terraform.tfvars
│       │   ├── terraform.tfvars.example
│       │   └── variables.tf
│       ├── prometheus-infrastructure.tf
│       └── variables.tf
├── ios/
│   ├── Flutter/
│   │   ├── AppFrameworkInfo.plist
│   │   ├── Debug.xcconfig
│   │   ├── Generated.xcconfig
│   │   ├── Release.xcconfig
│   │   ├── ephemeral/
│   │   │   ├── flutter_lldb_helper.py
│   │   │   └── flutter_lldbinit
│   │   └── flutter_export_environment.sh
│   ├── Runner/
│   │   ├── AppDelegate.swift
│   │   ├── Assets.xcassets/
│   │   │   ├── AppIcon.appiconset/
│   │   │   │   ├── Contents.json
│   │   │   │   └── [أيقونات متعددة]
│   │   │   └── LaunchImage.imageset/
│   │   │       ├── Contents.json
│   │   │       ├── LaunchImage.png
│   │   │       ├── LaunchImage@2x.png
│   │   │       ├── LaunchImage@3x.png
│   │   │       └── README.md
│   │   ├── Base.lproj/
│   │   │   ├── LaunchScreen.storyboard
│   │   │   └── Main.storyboard
│   │   ├── GeneratedPluginRegistrant.h
│   │   ├── GeneratedPluginRegistrant.m
│   │   ├── Info.plist
│   │   └── Runner-Bridging-Header.h
│   ├── Runner.xcodeproj/
│   │   ├── project.pbxproj
│   │   ├── project.xcworkspace/
│   │   │   ├── contents.xcworkspacedata
│   │   │   └── xcshareddata/
│   │   │       ├── IDEWorkspaceChecks.plist
│   │   │       └── WorkspaceSettings.xcsettings
│   │   └── xcshareddata/
│   │       └── xcschemes/
│   │           └── Runner.xcscheme
│   ├── Runner.xcworkspace/
│   │   ├── contents.xcworkspacedata
│   │   └── xcshareddata/
│   │       ├── IDEWorkspaceChecks.plist
│   │       └── WorkspaceSettings.xcsettings
│   └── RunnerTests/
│       └── RunnerTests.swift
├── lib/
│   ├── core/
│   │   ├── config/
│   │   │   ├── api_config.dart
│   │   │   └── app_config.dart
│   │   ├── database/
│   │   │   └── database_service.dart
│   │   ├── localization/
│   │   │   └── app_localizations.dart
│   │   ├── router/ (مغلق)
│   │   ├── security/
│   │   │   └── password_service.dart
│   │   └── services/
│   │       ├── api_client.dart
│   │       ├── api_service.dart
│   │       ├── logger.dart
│   │       ├── secure_storage_service.dart
│   │       ├── state_persistence_service.dart
│   │       └── time_sync_service.dart
│   ├── features/
│   │   ├── auth/
│   │   │   ├── models/
│   │   │   │   ├── auth_models.dart
│   │   │   │   ├── auth_models.g.dart
│   │   │   │   ├── auth_models_simple.dart
│   │   │   │   └── user_models.dart
│   │   │   ├── presentation/
│   │   │   │   ├── pages/ (مغلق)
│   │   │   │   └── screens/ (مغلق)
│   │   │   ├── providers/
│   │   │   │   └── auth_providers.dart
│   │   │   └── services/
│   │   │       ├── auth_service.dart
│   │   │       └── real_auth_service.dart
│   │   ├── customers/
│   │   │   ├── models/
│   │   │   │   └── customer_models_simple.dart
│   │   │   ├── presentation/
│   │   │   │   ├── pages/ (مغلق)
│   │   │   │   └── screens/ (مغلق)
│   │   │   └── services/
│   │   │       └── customer_service.dart
│   │   ├── dashboard/
│   │   │   └── presentation/
│   │   │       ├── pages/ (مغلق)
│   │   │       └── screens/ (مغلق)
│   │   ├── invoices/
│   │   │   ├── models/
│   │   │   │   ├── invoice_models.dart
│   │   │   │   └── invoice_models.g.dart
│   │   │   └── presentation/
│   │   │       ├── pages/ (مغلق)
│   │   │       └── screens/ (مغلق)
│   │   ├── settings/
│   │   │   └── presentation/
│   │   │       ├── pages/ (مغلق)
│   │   │       └── screens/ (مغلق)
│   │   └── zatca/
│   │       ├── presentation/
│   │       │   └── pages/ (مغلق)
│   │       └── services/
│   │           └── zatca_service.dart
│   ├── l10n/
│   │   ├── app_ar.arb
│   │   └── app_en.arb
│   └── main.dart
├── pubspec.lock
├── pubspec.yaml
├── src/
│   ├── backend/ (نسخة مكررة من backend/)
│   ├── frontend/ (نسخة مكررة من الواجهة الأمامية)
│   ├── infrastructure/ (نسخة مكررة من infrastructure/)
│   └── shared/
│       ├── monitoring/
│       │   ├── grafana/ (مغلق)
│       │   └── prometheus.yml
│       ├── nginx/
│       │   ├── nginx.conf
│       │   └── ssl/ (مغلق)
│       ├── redis/
│       │   └── redis.conf
│       ├── scripts/
│       │   └── init-db.sql
│       └── tests/
│           ├── integration/ (مغلق)
│           ├── performance/ (مغلق)
│           ├── security/ (مغلق)
│           └── usability/ (مغلق)
├── test/
│   ├── integration/
│   ├── unit/
│   │   ├── auth_service_test.dart
│   │   └── customer_service_test.dart
│   └── widget/
│       └── login_page_test.dart
└── web/
    ├── favicon.png
    ├── icons/
    │   ├── Icon-192.png
    │   ├── Icon-512.png
    │   ├── Icon-maskable-192.png
    │   └── Icon-maskable-512.png
    ├── index.html
    └── manifest.json
```