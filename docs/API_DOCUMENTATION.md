# 📚 API Documentation

Complete reference for EssenYemek Firestore database schema and backend services.

---

## Firestore Collections

### 1. `users` Collection

**Purpose**: Store user profiles and preferences

**Document ID**: `{user.uid}` (matches Firebase Auth UID)

**Schema**:
```typescript
{
  uid: string;                    // Firebase Auth UID
  email: string;                  // User email
  display_name?: string;          // Display name
  photo_url?: string;             // Profile picture URL
  phone_number?: string;          // Phone number
  created_time: timestamp;        // Account creation date
  diet?: string;                  // Diet preference (Vegan, Vegetarian, etc.)
  allergens?: string[];           // List of allergens to avoid
}
```

**Security Rules**:
```javascript
allow create, read, write, delete: if request.auth.uid == document;
```

**Example**:
```json
{
  "uid": "abc123",
  "email": "user@example.com",
  "display_name": "John Doe",
  "created_time": "2026-01-01T00:00:00Z",
  "diet": "Vegan",
  "allergens": ["Gluten", "Dairy"]
}
```

---

### 2. `meals` Collection

**Purpose**: Meal catalog with nutritional information

**Document ID**: Auto-generated

**Schema**:
```typescript
{
  meal_name: string;              // Meal title
  meal_image: string;             // Image URL (Unsplash or Firebase Storage)
  meal_ingredients: string;       // Comma-separated ingredients
  meal_allergens: string[];       // List of allergens
  meal_calories: number;          // Calories per serving
  meal_diet: string[];            // Diet tags (Vegan, High Protein, etc.)
  meal_favorites?: DocumentReference[];  // User refs who favorited
}
```

**Security Rules**:
```javascript
allow read: if request.auth != null;
allow write: if request.auth != null;  // Admin-only in production
allow create, delete: if false;
```

**Example**:
```json
{
  "meal_name": "Izgara Tavuk Salatası",
  "meal_image": "https://images.unsplash.com/photo-1546069901-ba9599a7e63c",
  "meal_ingredients": "Tavuk göğsü, yeşil salata, domates, salatalık, zeytinyağı, limon",
  "meal_allergens": [],
  "meal_calories": 380,
  "meal_diet": ["Dengeli", "Protein Ağırlıklı", "Düşük Kalori"]
}
```

---

### 3. `plans` Collection

**Purpose**: User weekly meal plans

**Document ID**: `{user.uid}` (one plan per user)

**Schema**:
```typescript
{
  user_ref: DocumentReference;    // Reference to users/{uid}
  user_id: string;                // User UID (denormalized)
  plan_type: string;              // Plan category (Dengeli, Fit, etc.)
  meals_per_week: number;         // 3-6 meals per week
  servings: number;               // 1-4 servings per meal
  delivery_day: string;           // Delivery day (Salı, Çarşamba, etc.)
  meal_refs: DocumentReference[]; // References to meals documents
  created_time: timestamp;        // Plan creation date
  updated_time: timestamp;        // Last update date
}
```

**Security Rules**:
```javascript
allow create, read, update, delete: if request.auth.uid == document;
```

**Example**:
```json
{
  "user_ref": "users/abc123",
  "user_id": "abc123",
  "plan_type": "Dengeli",
  "meals_per_week": 4,
  "servings": 2,
  "delivery_day": "Salı",
  "meal_refs": ["meals/meal1", "meals/meal2", "meals/meal3", "meals/meal4"],
  "created_time": "2026-01-01T00:00:00Z",
  "updated_time": "2026-01-01T12:00:00Z"
}
```

---

### 4. `orders` Collection

**Purpose**: Order history and tracking

**Document ID**: Auto-generated

**Schema**:
```typescript
{
  user_ref: DocumentReference;    // Reference to users/{uid}
  user_id: string;                // User UID (denormalized for queries)
  status: string;                 // Order status (Hazırlanıyor, Yolda, Teslim)
  eta: timestamp;                 // Estimated delivery time
  created_time: timestamp;        // Order creation date
  plan_type: string;              // Plan type at time of order
  meals_count: number;            // Number of meals in order
  servings: number;               // Servings per meal
  price: number;                  // Total price (TL)
  delivery_day: string;           // Delivery day
  meal_refs: DocumentReference[]; // Meals in this order
}
```

**Security Rules**:
```javascript
allow create: if request.auth != null && 
              request.resource.data.user_id == request.auth.uid;
allow read, update, delete: if request.auth != null && 
                               resource.data.user_id == request.auth.uid;
```

**Firestore Index**:
```json
{
  "collectionGroup": "orders",
  "queryScope": "COLLECTION",
  "fields": [
    {"fieldPath": "user_ref", "order": "ASCENDING"},
    {"fieldPath": "created_time", "order": "DESCENDING"}
  ]
}
```

**Example**:
```json
{
  "user_ref": "users/abc123",
  "user_id": "abc123",
  "status": "Yolda",
  "eta": "2026-01-03T18:00:00Z",
  "created_time": "2026-01-01T10:00:00Z",
  "plan_type": "Dengeli",
  "meals_count": 4,
  "servings": 2,
  "price": 632,
  "delivery_day": "Salı",
  "meal_refs": ["meals/meal1", "meals/meal2"]
}
```

---

### 5. `onboarding_options` Collection

**Purpose**: Configuration for onboarding screens

**Document ID**: Manual (e.g., "diets", "allergens")

**Schema**:
```typescript
{
  options: string[];  // List of available options
}
```

**Security Rules**:
```javascript
allow read: if true;
allow create, write, delete: if false;
```

---

### 6. `company_information` Collection

**Purpose**: Business information and settings

**Document ID**: `default`

**Schema**:
```typescript
{
  company_name: string;
  terms_url: string;
  privacy_url?: string;
  support_email?: string;
}
```

**Security Rules**:
```javascript
allow create: if document == 'default' && 
              !exists(/databases/$(database)/documents/company_information/default);
allow read: if true;
allow write, delete: if false;
```

---

### 7. `feedback` Collection

**Purpose**: User feedback submissions

**Document ID**: Auto-generated

**Schema**:
```typescript
{
  user_ref?: DocumentReference;
  message: string;
  created_time: timestamp;
  email?: string;
}
```

**Security Rules**:
```javascript
allow create: if request.auth != null;
allow read, write, delete: if false;
```

---

### 8. `support_center` Collection

**Purpose**: Help articles and FAQs

**Document ID**: Auto-generated

**Schema**:
```typescript
{
  title: string;
  content: string;
  category?: string;
  created_time: timestamp;
}
```

**Security Rules**:
```javascript
allow read: if request.auth != null;
allow create, write, delete: if false;
```

---

## Backend Services API

### MealService

**File**: `lib/backend/meal_service.dart`

#### Methods

**`streamMeals()`**
```dart
static Stream<List<MealsRecord>> streamMeals({
  FirebaseFirestore? firestore,
  List<String>? dietFilters,
  int? maxCalories,
  int limit = 20,
})
```
- **Purpose**: Stream meals with optional filters
- **Parameters**:
  - `dietFilters`: Filter by diet types (e.g., `['Vegan', 'Vegetarian']`)
  - `maxCalories`: Maximum calories per meal
  - `limit`: Max number of results (default: 20)
- **Returns**: Stream of `MealsRecord` list

**`fetchMeals()`**
```dart
static Future<List<MealsRecord>> fetchMeals({
  FirebaseFirestore? firestore,
  List<String>? dietFilters,
  int? maxCalories,
  int limit = 20,
})
```
- **Purpose**: Fetch meals once with optional filters
- **Returns**: Future of `MealsRecord` list

**`seedSampleMeals()`**
```dart
static Future<void> seedSampleMeals({
  FirebaseFirestore? firestore,
})
```
- **Purpose**: Populate Firestore with 30+ sample meals
- **Note**: Skips if meals already exist

---

### PlanService

**File**: `lib/backend/plan_service.dart`

#### Constants
```dart
static const String defaultPlanType = 'Dengeli';
static const int defaultMealsPerWeek = 4;
static const int defaultServings = 2;
static const String defaultDeliveryDay = 'Salı';
```

#### Methods

**`ensurePlan()`**
```dart
static Future<void> ensurePlan(
  DocumentReference userRef, {
  FirebaseFirestore? firestore,
})
```
- **Purpose**: Create default plan if it doesn't exist
- **Parameters**: `userRef` - Reference to user document

**`fetchPlan()`**
```dart
static Future<PlansRecord?> fetchPlan(
  DocumentReference userRef, {
  FirebaseFirestore? firestore,
})
```
- **Purpose**: Fetch user's plan once
- **Returns**: `PlansRecord` or `null`

**`streamPlan()`**
```dart
static Stream<PlansRecord?> streamPlan(
  DocumentReference userRef, {
  FirebaseFirestore? firestore,
})
```
- **Purpose**: Stream user's plan for real-time updates

**`savePlanFromState()`**
```dart
static Future<void> savePlanFromState({
  required FFAppState state,
  required DocumentReference userRef,
  FirebaseFirestore? firestore,
})
```
- **Purpose**: Save current app state to Firestore
- **Side Effect**: Trims `planMeals` to match `planMealsPerWeek`

**`applyPlanToState()`**
```dart
static void applyPlanToState({
  required FFAppState state,
  required PlansRecord plan,
})
```
- **Purpose**: Load Firestore plan into app state
- **Side Effect**: Updates `FFAppState` and notifies listeners

**`clearPlanState()`**
```dart
static void clearPlanState(FFAppState state)
```
- **Purpose**: Reset plan state to defaults (on logout)

---

### OrderService

**File**: `lib/backend/order_service.dart`

#### Constants
```dart
static const int pricePerServing = 79; // TL
```

#### Methods

**`createOrderFromPlan()`**
```dart
static Future<DocumentReference> createOrderFromPlan({
  required DocumentReference userRef,
  required FFAppState state,
  FirebaseFirestore? firestore,
})
```
- **Purpose**: Create order from current plan state
- **Price Calculation**: `mealsPerWeek × servings × pricePerServing`
- **Returns**: Reference to created order document

**`streamOrders()`**
```dart
static Stream<List<OrdersRecord>> streamOrders(
  DocumentReference userRef, {
  FirebaseFirestore? firestore,
})
```
- **Purpose**: Stream user's orders (newest first)

**`fetchOrders()`**
```dart
static Future<List<OrdersRecord>> fetchOrders(
  DocumentReference userRef, {
  FirebaseFirestore? firestore,
})
```
- **Purpose**: Fetch user's orders once

**`seedSampleOrders()`**
```dart
static Future<void> seedSampleOrders({
  required DocumentReference userRef,
  FirebaseFirestore? firestore,
})
```
- **Purpose**: Create sample orders for testing

---

### CompanyInformationService

**File**: `lib/backend/company_information_service.dart`

#### Methods

**`ensureDefaultCompanyInformation()`**
```dart
static Future<void> ensureDefaultCompanyInformation({
  FirebaseFirestore? firestore,
})
```
- **Purpose**: Create default company info on first app launch
- **Note**: Called in `main.dart` before app starts

---

## Query Examples

### Get all vegan meals under 400 calories

```dart
final meals = await MealService.fetchMeals(
  dietFilters: ['Vegan'],
  maxCalories: 400,
  limit: 10,
);
```

### Stream user's active orders

```dart
final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
final ordersStream = OrderService.streamOrders(userRef);

ordersStream.listen((orders) {
  final activeOrders = orders.where((o) => o.status != 'Teslim').toList();
  print('Active orders: ${activeOrders.length}');
});
```

### Save user plan

```dart
final appState = FFAppState();
final userRef = currentUserReference;

appState.update(() {
  appState.planType = 'Fit';
  appState.planMealsPerWeek = 5;
  appState.planServings = 2;
});

await PlanService.savePlanFromState(
  state: appState,
  userRef: userRef,
);
```

---

## Error Handling

All service methods should be wrapped in try-catch:

```dart
try {
  final meals = await MealService.fetchMeals();
  // Process meals
} on FirebaseException catch (e) {
  print('Firestore error: ${e.code} - ${e.message}');
  // Show user-friendly error
} catch (e) {
  print('Unexpected error: $e');
  // Generic error handling
}
```

---

## Testing

Use `fake_cloud_firestore` for unit tests:

```dart
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

test('fetchMeals returns filtered results', () async {
  final firestore = FakeFirebaseFirestore();
  
  // Seed test data
  await firestore.collection('meals').add({
    'meal_name': 'Test Meal',
    'meal_diet': ['Vegan'],
    'meal_calories': 350,
  });
  
  // Test service
  final meals = await MealService.fetchMeals(
    firestore: firestore,
    dietFilters: ['Vegan'],
    maxCalories: 400,
  );
  
  expect(meals.length, 1);
  expect(meals.first.mealName, 'Test Meal');
});
```

---

## Changelog

See [CHANGELOG.md](../CHANGELOG.md) for API changes and version history.
