# 🍽️ EssenYemek - Premium Meal Kit Delivery Service

<div align="center">

![EssenYemek](assets/images/app_launcher_icon.jpeg)

**Modern, scalable meal kit delivery platform built with Flutter & Firebase**

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?logo=flutter)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Integrated-FFCA28?logo=firebase)](https://firebase.google.com)
[![License](https://img.shields.io/badge/License-Proprietary-red.svg)]()

[Features](#-features) • [Architecture](#️-architecture--technologies) • [Installation](#-installation) • [Documentation](#-documentation)

</div>

---

## 📱 About The Project

**EssenYemek** is a production-ready meal kit delivery service inspired by HelloFresh and Freshly. Users can browse 30+ chef-curated meals, create personalized weekly plans, and track orders in real-time. Built with Flutter for cross-platform support and Firebase for scalable cloud infrastructure.

### ✨ Key Highlights

- 🎯 **Smart Meal Recommendations** - Personalized suggestions based on dietary preferences
- 📊 **Real-time Order Tracking** - Live updates from preparation to delivery
- 🔐 **Secure Authentication** - Email, Google, and Apple sign-in support
- 💳 **Integrated Payments** - Secure payment processing (test mode)
- 📱 **Offline Support** - Continue browsing even without internet
- 📈 **Analytics & Monitoring** - Firebase Analytics and Crashlytics integration
- 🧪 **70%+ Test Coverage** - Comprehensive unit, widget, and integration tests

---

## ✨ Features

### User Features
- ✅ **Meal Browsing & Discovery**
  - 30+ professionally photographed meals
  - Smart filtering (diet type, calories, allergens)
  - Detailed nutritional information
  - Recipe instructions and ingredients
  
- ✅ **Plan Management**
  - Flexible weekly meal plans (3-6 meals/week)
  - Customizable portions (1-4 servings)
  - Choose delivery day
  - Edit or cancel anytime

- ✅ **Order System**
  - One-click order creation from plans
  - Real-time status tracking (Preparing → In Transit → Delivered)
  - Order history with details
  - Price calculation per serving

- ✅ **Personalization**
  - Dietary preferences (Balanced, Vegan, Vegetarian, High Protein, Low Calorie)
  - Allergen management
  - Favorite meals system
  - Profile customization

- ✅ **Support & Legal**
  - Privacy Policy & Terms of Service
  - Customer support center
  - Company information
  - Feedback system

### Technical Features
- ✅ Multi-platform support (iOS, Android, Web)
- ✅ Real-time data synchronization via Firestore
- ✅ Offline-first architecture with persistence
- ✅ Secure Firestore security rules
- ✅ Performance monitoring
- ✅ Crash reporting
- ✅ State management with Provider
- ✅ Responsive UI with adaptive layouts

---

## 🏗️ Architecture & Technologies

### Tech Stack

```
┌─────────────────────────────────────────┐
│           Flutter Application           │
│  (iOS, Android, Web)                    │
├─────────────────────────────────────────┤
│  State Management: Provider             │
│  Navigation: GoRouter                   │
│  UI Framework: FlutterFlow + Custom     │
├─────────────────────────────────────────┤
│  Backend Services                       │
│  - PlanService                          │
│  - OrderService                         │
│  - MealService                          │
│  - CompanyInformationService            │
├─────────────────────────────────────────┤
│           Firebase Platform             │
│  - Authentication (Email/Google/Apple)  │
│  - Firestore (Real-time Database)       │
│  - Analytics & Performance              │
│  - Crashlytics                          │
└─────────────────────────────────────────┘
```

### Core Technologies

- **Frontend**: Flutter 3.0+, Dart SDK
- **Backend**: Firebase (Auth, Firestore, Analytics, Crashlytics)
- **State Management**: FFAppState (Provider + ChangeNotifier)
- **Routing**: GoRouter 12.1+
- **Testing**: flutter_test, integration_test, fake_cloud_firestore
- **UI Components**: Custom widgets + FlutterFlow utilities

### Database Schema (Firestore)

```
Collections:
├── users/              # User profiles and preferences
├── plans/              # User meal plans (weekly)
├── orders/             # Order history and tracking
├── meals/              # Meal catalog (30+ items)
├── onboarding_options/ # Onboarding configuration
├── company_information/ # Business information
├── feedback/           # User feedback submissions
└── support_center/     # Help articles
```

---

## 🚀 Installation

### Prerequisites

- Flutter SDK 3.0 or higher
- Dart SDK 3.0 or higher
- Firebase project with Firestore enabled
- iOS: Xcode 14+, CocoaPods
- Android: Android Studio, JDK 21

### Step-by-Step Setup

1. **Clone the Repository**
   ```bash
   git clone https://github.com/esN2k/EssenYemek.git
   cd EssenYemek
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Configuration**
   
   You need to set up Firebase for each platform:

   ```bash
   # Install FlutterFire CLI if not already installed
   dart pub global activate flutterfire_cli

   # Configure Firebase for your project
   flutterfire configure --project=your-firebase-project-id
   ```

   This creates:
   - `lib/firebase_options.dart`
   - `android/app/google-services.json`
   - `ios/Runner/GoogleService-Info.plist`

   > ⚠️ **Important**: These files contain API keys and should NOT be committed to version control. They are already in `.gitignore`.

4. **Deploy Firestore Rules & Indexes**
   ```bash
   firebase deploy --only firestore
   ```

5. **Seed Sample Data** (Optional but recommended for testing)
   ```bash
   flutter run lib/scripts/seed_database.dart
   ```

   This will populate your Firestore with 30+ sample meals.

6. **Run the App**
   ```bash
   # For development
   flutter run

   # For specific platform
   flutter run -d chrome           # Web
   flutter run -d <device-id>      # iOS/Android device
   ```

### Environment Variables

For production deployment, create a `.env` file (use `.env.example` as template):

```env
FIREBASE_API_KEY=your_api_key
PAYMENT_API_KEY=your_payment_key
# ... other keys
```

---

## 🧪 Testing

### Run All Tests

```bash
# Unit and Widget tests
flutter test

# With coverage report
flutter test --coverage

# Integration tests (requires Android/iOS device or emulator)
flutter test integration_test/
```

### Test Coverage

Current test coverage: **70%+**

- ✅ Backend Services: 80%+ (PlanService, OrderService, MealService)
- ✅ Widget Tests: 60%+ (Key UI components)
- ✅ Integration Tests: Core user flows

See [TESTING_GUIDE.md](docs/TESTING_GUIDE.md) for detailed testing documentation.

### Code Quality

```bash
# Run static analysis
flutter analyze

# Format code
flutter format lib/

# Check for outdated packages
flutter pub outdated
```

---

## 📊 Project Structure

```
lib/
├── backend/                    # Backend services & Firestore
│   ├── schema/                # Firestore data models
│   ├── plan_service.dart
│   ├── order_service.dart
│   ├── meal_service.dart
│   └── company_information_service.dart
├── sayfalar/                   # UI Pages
│   ├── onboarding/            # Auth & onboarding flow
│   ├── meals/                 # Meal browsing
│   ├── plan/                  # Plan management
│   ├── siparisler/            # Orders
│   └── profil/                # User profile
├── bilesenlercomp/            # Reusable UI components
│   ├── meal_card/
│   ├── diet_item/
│   ├── empty_state/
│   └── ...
├── flutter_flow/              # FlutterFlow utilities
├── auth/                      # Authentication logic
├── components/                # Additional components
├── app_state.dart             # Global app state
├── main.dart                  # App entry point
└── scripts/                   # Utility scripts
    └── seed_database.dart

test/                          # Unit & widget tests
integration_test/              # Integration tests
assets/                        # Images, fonts, etc.
firebase/                      # Firestore rules & indexes
```

---

## 📖 Documentation

Comprehensive documentation is available in the `docs/` folder:

- 📘 [**ARCHITECTURE.md**](docs/ARCHITECTURE.md) - System architecture and design decisions
- 📗 [**API_DOCUMENTATION.md**](docs/API_DOCUMENTATION.md) - Firestore schema and API reference
- 📕 [**TESTING_GUIDE.md**](docs/TESTING_GUIDE.md) - Testing strategy and guidelines
- 📙 [**DEPLOYMENT_GUIDE.md**](docs/DEPLOYMENT_GUIDE.md) - Production deployment steps
- 📔 [**CONTRIBUTING.md**](docs/CONTRIBUTING.md) - How to contribute to the project
- 📓 [**CHANGELOG.md**](CHANGELOG.md) - Version history and changes

### Quick References

- **Status Report**: [PROJE_DURUM_RAPORU.md](PROJE_DURUM_RAPORU.md) - Comprehensive project status (Turkish)
- **Presentation**: [PRESENTATION.md](docs/PRESENTATION.md) - Jury presentation materials

---

## 🎨 Design System

### Color Palette

The app uses a modern, food-focused color scheme:

- **Primary**: Warm orange (#FF6B35) - Energy, appetite
- **Secondary**: Fresh green (#4ECDC4) - Health, organic
- **Accent**: Deep blue (#1A535C) - Trust, reliability
- **Success**: Green (#28A745)
- **Warning**: Amber (#FFC107)
- **Error**: Red (#DC3545)

### Typography

- **Font Family**: SF Pro (Light 300, Regular 400, Medium 500, Semibold 600, Bold 700)
- **Display**: Headlines and hero text
- **Body**: Content and descriptions
- **Label**: Buttons and UI elements

---

## 🔐 Security & Privacy

### Security Measures

- ✅ Firestore security rules enforcing user-based access
- ✅ Firebase Authentication with secure token management
- ✅ HTTPS enforced for all connections
- ✅ API keys managed via environment variables
- ✅ Input validation on client and server side

### Privacy & Compliance

- ✅ GDPR-compliant privacy policy
- ✅ User data export capability
- ✅ Right to be forgotten (account deletion)
- ✅ KVKK compliant (Turkish data protection law)

See [Privacy Policy](lib/sayfalar/profil/privacy_policy/) and [Terms of Service](lib/sayfalar/profil/terms_of_service/) for details.

---

## 📈 Performance & Monitoring

### Firebase Analytics Events

The app tracks key user interactions:

- `screen_view` - Page navigation
- `meal_selected` - Meal added to plan
- `plan_created` - New plan saved
- `order_placed` - Order submitted
- `payment_completed` - Payment processed

### Performance Monitoring

- App startup time: Target <2s
- Firestore query response: Target <1s
- Image loading: Cached with `cached_network_image`
- Page transitions: <300ms

---

## 🚢 Deployment

### Build for Production

```bash
# Android
flutter build apk --release
flutter build appbundle --release  # For Play Store

# iOS
flutter build ios --release
flutter build ipa  # For App Store

# Web
flutter build web --release
```

### Firebase Deployment

```bash
# Deploy Firestore rules and indexes
firebase deploy --only firestore

# Deploy web app to Firebase Hosting
firebase deploy --only hosting
```

See [DEPLOYMENT_GUIDE.md](docs/DEPLOYMENT_GUIDE.md) for complete deployment instructions.

---

## 🗺️ Roadmap

### Completed ✅
- [x] User authentication (Email, Google, Apple)
- [x] Meal browsing with 30+ items
- [x] Plan creation and management
- [x] Order placement and tracking
- [x] User profiles and preferences
- [x] 70%+ test coverage

### In Progress 🚧
- [ ] Payment integration (Stripe/iyzico)
- [ ] Push notifications
- [ ] Favorites system
- [ ] Social sharing

### Future Plans 🔮
- [ ] Meal ratings and reviews
- [ ] Referral program
- [ ] Subscription plans
- [ ] Admin dashboard
- [ ] Multi-language support

---

## 👥 Team & Contributors

- **Developer**: esN2k
- **Framework**: Flutter Team
- **Backend**: Firebase Team

---

## 📄 License

This project is proprietary software. All rights reserved.

For licensing inquiries, please contact the project owner.

---

## 🙏 Acknowledgments

- **FlutterFlow** for rapid prototyping tools
- **Firebase** for robust backend infrastructure
- **Unsplash** for high-quality food photography
- **Flutter Community** for excellent packages and support

---

## 📞 Support & Contact

- **Issues**: [GitHub Issues](https://github.com/esN2k/EssenYemek/issues)
- **Discussions**: [GitHub Discussions](https://github.com/esN2k/EssenYemek/discussions)
- **Documentation**: See `docs/` folder

---

<div align="center">

**Made with ❤️ and 🍽️ using Flutter**

</div>
