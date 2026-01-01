# 🏗️ EssenYemek - Architecture Documentation

This document describes the system architecture, design decisions, and technical implementation details of the EssenYemek platform.

---

## Table of Contents

1. [System Overview](#system-overview)
2. [Architecture Patterns](#architecture-patterns)
3. [Tech Stack](#tech-stack)
4. [Layer Architecture](#layer-architecture)
5. [State Management](#state-management)
6. [Data Flow](#data-flow)
7. [Firebase Integration](#firebase-integration)
8. [Security Architecture](#security-architecture)
9. [Performance Optimization](#performance-optimization)
10. [Design Decisions](#design-decisions)

---

## System Overview

EssenYemek is a Flutter-based meal kit delivery platform using Firebase as the backend infrastructure. The app follows a clean architecture pattern with clear separation of concerns.

### High-Level Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    User Interface Layer                  │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │  Onboarding  │  │   Meals/     │  │   Profile/   │  │
│  │   Screens    │  │  Plan/Order  │  │   Settings   │  │
│  └──────────────┘  └──────────────┘  └──────────────┘  │
└─────────────────────────────────────────────────────────┘
                            ↕
┌─────────────────────────────────────────────────────────┐
│                State Management Layer                    │
│  ┌────────────────────────────────────────────────────┐ │
│  │  FFAppState (Provider + ChangeNotifier)            │ │
│  │  - planType, planMeals, planServings               │ │
│  │  - userDiet, userAllergens                         │ │
│  └────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────┘
                            ↕
┌─────────────────────────────────────────────────────────┐
│                  Business Logic Layer                    │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │ MealService  │  │ PlanService  │  │OrderService  │  │
│  │              │  │              │  │              │  │
│  │ - seedMeals  │  │ - ensurePlan │  │ - createOrder│  │
│  │ - fetchMeals │  │ - savePlan   │  │ - fetchOrders│  │
│  │ - streamMeals│  │ - streamPlan │  │ - streamOrders│ │
│  └──────────────┘  └──────────────┘  └──────────────┘  │
└─────────────────────────────────────────────────────────┘
                            ↕
┌─────────────────────────────────────────────────────────┐
│                     Data Layer                           │
│  ┌────────────────────────────────────────────────────┐ │
│  │              Firebase Platform                      │ │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────┐         │ │
│  │  │Firestore │  │   Auth   │  │Analytics │         │ │
│  │  └──────────┘  └──────────┘  └──────────┘         │ │
│  └────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────┘
```

---

## Architecture Patterns

### 1. Clean Architecture

The app follows Clean Architecture principles with clear separation of concerns:

```
lib/
├── sayfalar/          # Presentation Layer (UI)
│   └── [feature]/     # Feature-based organization
├── bilesenlercomp/    # Reusable UI Components
├── backend/           # Business Logic Layer
│   ├── services/      # Business logic services
│   └── schema/        # Data models
└── flutter_flow/      # Framework utilities
```

### 2. Service Layer Pattern

All business logic is encapsulated in service classes:

```dart
// Service interface example
class PlanService {
  static Future<void> ensurePlan(DocumentReference userRef);
  static Future<PlansRecord?> fetchPlan(DocumentReference userRef);
  static Stream<PlansRecord?> streamPlan(DocumentReference userRef);
  static Future<void> savePlanFromState({...});
  static void applyPlanToState({...});
}
```

**Benefits**:
- Testability (services can be mocked)
- Reusability across different UI screens
- Single source of truth for business logic
- Easy to refactor and maintain

### 3. Repository Pattern (Implicit)

Firestore collections act as repositories:

```dart
// Collection reference
static CollectionReference<Map<String, dynamic>> mealsCollection({
  FirebaseFirestore? firestore,
}) {
  final db = firestore ?? FirebaseFirestore.instance;
  return db.collection('meals');
}
```

---

## Tech Stack

### Frontend

| Component | Technology | Version | Purpose |
|-----------|------------|---------|---------|
| Framework | Flutter | 3.0+ | Cross-platform UI |
| Language | Dart | 3.0+ | Programming language |
| State | Provider | 6.1.2 | State management |
| Navigation | GoRouter | 12.1.3 | Declarative routing |
| UI Components | FlutterFlow + Custom | - | Rapid development |

### Backend

| Component | Technology | Purpose |
|-----------|------------|---------|
| Authentication | Firebase Auth | User management |
| Database | Cloud Firestore | NoSQL real-time DB |
| Analytics | Firebase Analytics | User behavior tracking |
| Monitoring | Firebase Crashlytics | Error reporting |
| Hosting | Firebase Hosting | Web deployment |

### Development Tools

| Tool | Purpose |
|------|---------|
| flutter_test | Unit/widget testing |
| integration_test | E2E testing |
| fake_cloud_firestore | Firestore mocking |
| flutter_lints | Code quality |

---

## Layer Architecture

### 1. Presentation Layer

**Location**: `lib/sayfalar/`, `lib/bilesenlercomp/`

**Responsibilities**:
- Render UI
- Handle user input
- Display data from state
- Navigate between screens

**Example**:
```dart
class PlanWidget extends StatefulWidget {
  @override
  State<PlanWidget> createState() => _PlanWidgetState();
}

class _PlanWidgetState extends State<PlanWidget> {
  @override
  Widget build(BuildContext context) {
    // Access global state
    final appState = FFAppState();
    
    return Scaffold(
      body: Column(
        children: [
          Text('Plan Type: ${appState.planType}'),
          // ... UI components
        ],
      ),
    );
  }
}
```

### 2. State Management Layer

**Location**: `lib/app_state.dart`

**Pattern**: Provider + ChangeNotifier

**Responsibilities**:
- Store global app state
- Notify listeners on changes
- Provide state to widgets

**State Structure**:
```dart
class FFAppState extends ChangeNotifier {
  // Plan state
  String _planType = 'Dengeli';
  int _planMealsPerWeek = 4;
  int _planServings = 2;
  String _planDeliveryDay = 'Salı';
  List<DocumentReference> _planMeals = [];
  
  // User preferences
  String _userDiet = '';
  List<String> _userAllergens = [];
  
  // Update method
  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }
}
```

### 3. Business Logic Layer

**Location**: `lib/backend/`

**Services**:
1. **MealService** - Meal catalog management
2. **PlanService** - Plan CRUD operations
3. **OrderService** - Order management
4. **CompanyInformationService** - Business data

**Example Service**:
```dart
class MealService {
  // Fetch meals with filters
  static Future<List<MealsRecord>> fetchMeals({
    FirebaseFirestore? firestore,
    List<String>? dietFilters,
    int? maxCalories,
    int limit = 20,
  }) async {
    var query = mealsCollection(firestore: firestore).limit(limit);
    
    if (dietFilters != null && dietFilters.isNotEmpty) {
      query = query.where('meal_diet', arrayContainsAny: dietFilters);
    }
    
    final snapshot = await query.get();
    return snapshot.docs
        .map((doc) => MealsRecord.fromSnapshot(doc))
        .where((meal) => maxCalories == null || meal.mealCalories <= maxCalories)
        .toList();
  }
}
```

### 4. Data Layer

**Location**: `lib/backend/schema/`

**Responsibilities**:
- Define data models
- Firestore serialization/deserialization
- Type-safe data access

**Example Record**:
```dart
class MealsRecord extends FirestoreRecord {
  String get mealName => _mealName ?? '';
  String get mealImage => _mealImage ?? '';
  List<String> get mealDiet => _mealDiet ?? const [];
  int get mealCalories => _mealCalories ?? 0;
  
  static MealsRecord fromSnapshot(DocumentSnapshot snapshot) {
    // Deserialization logic
  }
}
```

---

## State Management

### Provider Architecture

```
┌────────────────────────────────────────┐
│         MyApp (Root Widget)            │
│  ┌──────────────────────────────────┐  │
│  │  ChangeNotifierProvider          │  │
│  │  create: (_) => FFAppState()     │  │
│  │          │                        │  │
│  │          ↓                        │  │
│  │  ┌────────────────────┐          │  │
│  │  │  Consumer Widgets  │          │  │
│  │  │  - Read state      │          │  │
│  │  │  - Trigger updates │          │  │
│  │  └────────────────────┘          │  │
│  └──────────────────────────────────┘  │
└────────────────────────────────────────┘
```

### State Update Flow

```
User Action → Widget → Service → Firestore
                 ↓
        FFAppState.update()
                 ↓
        notifyListeners()
                 ↓
           UI Rebuilds
```

### Example State Update

```dart
// 1. User taps "Save Plan" button
onPressed: () async {
  final appState = FFAppState();
  final userRef = currentUserReference;
  
  // 2. Service updates Firestore
  await PlanService.savePlanFromState(
    state: appState,
    userRef: userRef,
  );
  
  // 3. Stream subscription updates state
  // (handled automatically via streamPlan)
}
```

---

## Data Flow

### Real-time Synchronization

```
Firestore → Stream → Service → FFAppState → UI
   │                                          │
   └──────────← User Action ←────────────────┘
```

### Plan Synchronization Example

```dart
// In main.dart
authUserSub = authenticatedUserStream.listen((userDoc) async {
  if (userDoc == null) {
    await planSub?.cancel();
    PlanService.clearPlanState(FFAppState());
    return;
  }
  
  final userRef = userDoc.reference;
  
  // Ensure plan exists
  await PlanService.ensurePlan(userRef);
  
  // Fetch initial plan
  final plan = await PlanService.fetchPlan(userRef);
  if (plan != null) {
    PlanService.applyPlanToState(state: FFAppState(), plan: plan);
  }
  
  // Subscribe to real-time updates
  await planSub?.cancel();
  planSub = PlanService.streamPlan(userRef).listen((plan) {
    if (plan == null) return;
    PlanService.applyPlanToState(state: FFAppState(), plan: plan);
  });
});
```

---

## Firebase Integration

### Firestore Collections

| Collection | Purpose | Access Control |
|------------|---------|----------------|
| users | User profiles | User-owned (uid-based) |
| plans | Meal plans | User-owned (uid-based) |
| orders | Order history | User-owned (user_ref) |
| meals | Meal catalog | Public read, admin write |
| onboarding_options | Onboarding data | Public read-only |
| company_information | Business info | Public read, one-time create |
| feedback | User feedback | Auth create-only |
| support_center | Help articles | Auth read-only |

### Security Rules

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // User documents - full control by owner
    match /users/{document} {
      allow create, read, write, delete: 
        if request.auth.uid == document;
    }
    
    // Plans - user-owned
    match /plans/{document} {
      allow create, read, update, delete: 
        if request.auth.uid == document;
    }
    
    // Orders - user-based access via user_id field
    match /orders/{document} {
      allow create: 
        if request.auth != null &&
           request.resource.data.user_id == request.auth.uid;
      allow read, update, delete: 
        if request.auth != null &&
           resource.data.user_id == request.auth.uid;
    }
    
    // Meals - public read for authenticated users
    match /meals/{document} {
      allow create, delete: if false;
      allow read: if request.auth != null;
      allow write: if request.auth != null;
    }
  }
}
```

### Firebase Initialization

```dart
// main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await initFirebase();
  
  // Ensure company information exists
  await CompanyInformationService.ensureDefaultCompanyInformation();
  
  // Initialize theme and localization
  await FlutterFlowTheme.initialize();
  await FFLocalizations.initialize();
  
  // Initialize app state
  final appState = FFAppState();
  await appState.initializePersistedState();
  
  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: const MyApp(),
  ));
}
```

---

## Security Architecture

### Authentication Flow

```
User Input → Firebase Auth → Token → Firestore Rules → Data Access
```

### Multi-Provider Auth

Supported providers:
1. **Email/Password** - Traditional auth
2. **Google Sign-In** - OAuth 2.0
3. **Apple Sign-In** - Required for iOS

### Token Management

- Tokens automatically refreshed by Firebase SDK
- Token stored securely in platform keychain
- Token validated on every Firestore request

### Input Validation

**Client-side**:
```dart
// Example form validation
validator: (value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    return 'Please enter a valid email';
  }
  return null;
}
```

**Server-side** (Firestore Rules):
```javascript
match /orders/{orderId} {
  allow create: if 
    request.resource.data.user_id == request.auth.uid &&
    request.resource.data.price is number &&
    request.resource.data.price > 0;
}
```

---

## Performance Optimization

### 1. Image Caching

```dart
// Using cached_network_image
CachedNetworkImage(
  imageUrl: meal.mealImage,
  placeholder: (context, url) => CircularProgressIndicator(),
  errorWidget: (context, url, error) => Icon(Icons.error),
  memCacheWidth: 800, // Limit memory usage
)
```

### 2. Firestore Query Optimization

```dart
// Limit queries
query.limit(20)

// Use indexes for compound queries
query
  .where('meal_diet', arrayContainsAny: ['Vegan'])
  .orderBy('meal_calories')
  .limit(10)
```

### 3. Lazy Loading

```dart
// ListView.builder for efficient rendering
ListView.builder(
  itemCount: meals.length,
  itemBuilder: (context, index) {
    return MealCard(meal: meals[index]);
  },
)
```

### 4. Offline Persistence

```dart
// Enable Firestore offline persistence
await FirebaseFirestore.instance.settings = Settings(
  persistenceEnabled: true,
  cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
);
```

---

## Design Decisions

### Why Flutter?

**Pros**:
- ✅ Single codebase for iOS, Android, Web
- ✅ Hot reload for fast development
- ✅ Rich widget library
- ✅ Strong performance (compiled to native)
- ✅ Growing ecosystem

**Cons**:
- ⚠️ Larger app size than native
- ⚠️ Platform-specific features require plugins

**Decision**: Pros outweigh cons for MVP and scale.

### Why Firebase?

**Pros**:
- ✅ Quick setup, no server management
- ✅ Auto-scaling infrastructure
- ✅ Real-time capabilities out of box
- ✅ Integrated analytics and monitoring
- ✅ Security rules for access control

**Cons**:
- ⚠️ Vendor lock-in
- ⚠️ Costs can scale with usage

**Decision**: Time-to-market and scalability more important than vendor lock-in for early stage.

### Why Provider over Riverpod/Bloc?

**Reasons**:
- ✅ Simpler learning curve
- ✅ Well-integrated with FlutterFlow
- ✅ Sufficient for current scale
- ✅ Easy to refactor later if needed

**Future**: Consider Riverpod for complex state logic.

### Why Service Layer?

**Reasons**:
- ✅ Testability - Services can be mocked
- ✅ Reusability - Used across multiple screens
- ✅ Single source of truth for business logic
- ✅ Clear separation from UI

---

## Scalability Considerations

### Current Limitations

1. **Firestore Free Tier**:
   - 50K reads/day
   - 20K writes/day
   - Solution: Upgrade to Blaze plan

2. **Client-side Filtering**:
   - Some filtering done in Dart code
   - Solution: Move to Firestore queries with indexes

3. **No Pagination**:
   - All meals loaded at once
   - Solution: Implement cursor-based pagination

### Future Improvements

1. **Cloud Functions**:
   - Scheduled jobs (order processing)
   - Complex business logic
   - Third-party integrations

2. **Cloud Storage**:
   - User-uploaded profile photos
   - Recipe images

3. **Firebase Extensions**:
   - Trigger email (order confirmation)
   - Resize images
   - Stripe payments

---

## Conclusion

EssenYemek follows a clean, layered architecture with clear separation of concerns. The service layer pattern ensures testability and maintainability, while Firebase provides a scalable backend infrastructure. The architecture is designed to evolve with the product, allowing for easy feature additions and refactoring as needed.

For questions or suggestions, please refer to the [CONTRIBUTING.md](CONTRIBUTING.md) guide.
