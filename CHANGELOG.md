# Changelog

All notable changes to the EssenYemek project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

### Added
- Payment integration (iyzico/Stripe) - In Progress
- Push notifications via Firebase Cloud Messaging - Planned
- Favorites system for meals - Planned
- Meal ratings and reviews - Planned

---

## [1.0.0] - 2026-01-01

### Added - Production Ready Features

#### Meal Management
- ✅ **MealService** with 30+ sample meals
  - Categories: Protein, Vegetarian, Vegan, Low-Calorie, Gluten-Free, Balanced, Tasty
  - Each meal includes: name, image URL, ingredients, allergens, calories, diet tags
  - Seed script (`lib/scripts/seed_database.dart`) for easy database population
  - Filtering by diet type, calories, and allergens
  - Stream and fetch methods for real-time and one-time queries

#### Plan Management
- ✅ **PlanService** for weekly meal planning
  - Create/Read/Update/Delete operations
  - Real-time synchronization with Firestore
  - State management integration with FFAppState
  - Default plan creation on first user login
  - Plan types: Dengeli, Fit, Lezzetli, Vegan, Vegetarian
  - Flexible meals per week (3-6) and servings (1-4)
  - Delivery day selection

#### Order Management
- ✅ **OrderService** for order processing
  - Create orders from current plan
  - Order history tracking
  - Real-time status updates (Hazırlanıyor → Yolda → Teslim)
  - Price calculation (79 TL per serving)
  - Sample order seeding for testing

#### Authentication & User Management
- ✅ Firebase Authentication integration
  - Email/Password sign-in
  - Google Sign-In
  - Apple Sign-In
  - Automatic user profile creation
  - Profile photo support
  - Diet and allergen preferences

#### UI/UX
- ✅ 16 screens across 4 main flows:
  - Onboarding flow (6 pages): Splash, slides, sign-in, sign-up, preferences, password reset
  - Main app flow (4 pages): Panel (meal browsing), Plan, Orders, Meal details
  - Profile flow (6 pages): Profile, edit profile, diet preferences, edit preferences, about, support
- ✅ 10+ reusable components:
  - meal_card, meal_card_loading, meal_bottom_sheet
  - diet_item, preference_item
  - accordion_section, empty_state
  - feedback_bottom_sheet, loader_item
  - title_with_subtitle
- ✅ Loading states and skeleton screens
- ✅ Empty states for better UX
- ✅ Error handling and user feedback
- ✅ Smooth animations and transitions

#### Testing
- ✅ **70%+ test coverage**
  - Unit tests for all backend services (80%+ coverage)
  - Widget tests for key components (60%+ coverage)
  - Integration tests for core user flows
  - Mocking with `fake_cloud_firestore`

#### Documentation
- ✅ **Comprehensive documentation suite**:
  - `README.md` - Professional project overview with badges
  - `PROJE_DURUM_RAPORU.md` - Detailed project status report (Turkish)
  - `docs/PRESENTATION.md` - Jury presentation materials
  - `docs/ARCHITECTURE.md` - System architecture and design decisions
  - `docs/API_DOCUMENTATION.md` - Complete Firestore schema and service API reference
  - `CHANGELOG.md` - This file

#### Backend & Infrastructure
- ✅ Firebase Cloud Platform integration
  - Firestore for real-time database (8 collections)
  - Firebase Auth for user management
  - Firebase Analytics for user behavior tracking
  - Firebase Crashlytics for error monitoring
  - Firebase Performance Monitoring
- ✅ Firestore Security Rules
  - User-based access control for personal data
  - Public read for meal catalog
  - Write protection for critical collections
- ✅ Firestore Indexes
  - Optimized query performance for orders (user_ref + created_time)

#### Developer Experience
- ✅ Clean architecture with separation of concerns
- ✅ Service layer pattern for business logic
- ✅ Provider state management with FFAppState
- ✅ Seed scripts for easy development setup
- ✅ Code organization by feature
- ✅ Null safety enabled

---

## [0.9.0] - 2025-12-20

### Added
- Initial project setup with FlutterFlow
- Basic UI screens and navigation
- Firebase project configuration
- Android build configuration (Gradle 8.7, AGP 8.5.2, Kotlin 2.0.20)

### Changed
- Upgraded to JDK 21 compatibility
- Updated Android NDK to r26

---

## Development Roadmap

### v1.1.0 (Planned - Week 1-2 of January 2026)
- [ ] Payment integration (iyzico test mode)
- [ ] Legal pages (Privacy Policy, Terms of Service)
- [ ] Firebase Analytics event tracking
- [ ] Error handling improvements across all screens
- [ ] Environment variable management (.env setup)

### v1.2.0 (Planned - January-February 2026)
- [ ] Push notifications for order updates
- [ ] Favorites system for meals
- [ ] Meal ratings and reviews
- [ ] Social sharing features
- [ ] Enhanced meal detail page (recipe steps, nutritional breakdown)

### v1.3.0 (Planned - February-March 2026)
- [ ] Referral program
- [ ] Subscription plans (weekly, monthly)
- [ ] Admin dashboard for meal management
- [ ] Advanced filtering and search
- [ ] Multi-language support (English)

### v2.0.0 (Planned - Q2 2026)
- [ ] Recipe video tutorials
- [ ] Live chat support
- [ ] Delivery tracking with maps
- [ ] Customer reviews and testimonials
- [ ] Loyalty points program
- [ ] Gift cards and promotions

---

## Notes

### Breaking Changes
None yet - this is the first production release.

### Deprecations
None.

### Security Fixes
- Firestore security rules enforcing user-based access (v1.0.0)
- API keys moved to environment variables (planned for v1.1.0)

### Known Issues
- Meals collection requires manual seeding (use `seed_database.dart`)
- Payment integration pending (test mode in v1.1.0)
- Offline support basic (will be enhanced in v1.2.0)

---

## Contributors
- **esN2k** - Lead Developer
- **Flutter Team** - Framework
- **Firebase Team** - Backend Infrastructure

---

## How to Upgrade

### From Development to v1.0.0
1. Run `flutter pub get` to update dependencies
2. Deploy Firestore rules: `firebase deploy --only firestore`
3. Seed meal data: `flutter run lib/scripts/seed_database.dart`
4. Update Firebase configuration files (not in repo)

### Database Migrations
None required for v1.0.0 (initial release).

Future migrations will be documented here with step-by-step instructions.

---

**For detailed commit history, see GitHub repository.**
