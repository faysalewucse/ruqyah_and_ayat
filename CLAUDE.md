# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter mobile application called "Ruqyah & Ayaat" - an Islamic app providing religious content including Quranic verses, supplications (duas), audio recitations, articles on Ruqyah (Islamic exorcism), and Hijama (cupping therapy). The app follows a clean architecture with feature-based organization.

## Essential Commands

### Development
- `flutter run` - Run the app in development mode
- `flutter build apk` - Build Android APK
- `flutter build appbundle` - Build Android App Bundle for Play Store
- `flutter analyze` - Static analysis of Dart code
- `flutter test` - Run unit tests

### Hive Database Code Generation
- `flutter pub run build_runner build` - Generate Hive adapters and other code generation files
- `flutter pub run build_runner build --delete-conflicting-outputs` - Force regenerate all generated files

### Icon Generation
- `flutter pub run flutter_launcher_icons:main` - Generate app icons from assets/icons/app_icon.png

## Architecture & Key Components

### State Management
- **GetX**: Primary state management solution using Get.put() for dependency injection
- **Controllers**: All business logic is handled through GetX controllers in `lib/controllers/`
- **Bindings**: Dependencies are registered in `lib/bindings.dart` via MyBindings class

### Data Layer
- **Hive**: Local NoSQL database for offline storage of all content
- **Hive Boxes**: Defined in `lib/helper/hive_boxes.dart` - each content type has its own box
- **Models**: All data models in `lib/models/` with Hive adapters (*.g.dart files generated)
- **API Layer**: Remote data fetching in `lib/api/` with Dio for HTTP requests

### Core Storage Boxes
```dart
categoryBox - Categories for organizing content
versesBox - Quranic verses
ruqyahsBox - Ruqyah articles
hijamasBox - Hijama therapy articles
masnunDuaBox - Prophetic supplications
audioBox - Audio categories and files
masayelBox - Islamic jurisprudence questions
```

### Feature Organization
- **Features**: Located in `lib/features/` with feature-specific controllers and UI
- **Routing**: GetX routing with routes defined in `lib/router/routes.dart`
- **Navigation**: App uses named routes with GetX navigation

### Key Controllers
- **DataController**: Handles API data fetching and syncing with local storage
- **NetworkController**: Manages connectivity and network state
- **StorageController**: Manages app settings and preferences
- **KeeperController**: Handles theme management and app-wide state

### App Initialization Flow
1. Firebase initialization (Core + Messaging for notifications)
2. Hive database setup with model adapters
3. Network controller initialization
4. Controller dependency injection via GetX
5. App launch with GetMaterialApp and theme management

### Content Structure
- **Multilingual**: Supports Bengali and Arabic text with custom Quranic fonts
- **Audio**: Integrated audio playback with just_audio package
- **Fonts**: Multiple Quranic and Arabic fonts in assets/fonts/
- **Offline-First**: All content cached locally via Hive for offline access

### Firebase Integration
- **Core**: App analytics and configuration
- **Messaging**: Push notifications for updates
- **Configuration**: Uses firebase_options.dart for platform-specific setup

### Model Generation
When modifying models in `lib/models/`, you must regenerate Hive adapters:
1. Add `@HiveType()` and `@HiveField()` annotations
2. Run `flutter pub run build_runner build`
3. Commit both the model file and generated `.g.dart` file

### Theme System
- Light and dark themes defined in `utils/constants/app_theme.dart`
- Theme switching handled by KeeperController
- Custom colors defined in `utils/constants/app_colors.dart`

## Testing
- Unit tests should be placed in `test/` directory
- Widget tests for UI components
- Use `flutter test` to run all tests