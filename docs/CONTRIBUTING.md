# Contributing to EssenYemek

Thank you for your interest in contributing to EssenYemek! This document provides guidelines and instructions for contributing to the project.

---

## Table of Contents

1. [Code of Conduct](#code-of-conduct)
2. [Getting Started](#getting-started)
3. [Development Workflow](#development-workflow)
4. [Coding Standards](#coding-standards)
5. [Commit Message Guidelines](#commit-message-guidelines)
6. [Pull Request Process](#pull-request-process)
7. [Testing Requirements](#testing-requirements)
8. [Documentation](#documentation)

---

## Code of Conduct

This project adheres to a code of professional conduct. By participating, you are expected to uphold this code:

- Be respectful and inclusive
- Provide constructive feedback
- Focus on what is best for the community
- Show empathy towards other community members

---

## Getting Started

### Prerequisites

- Flutter SDK 3.0+
- Dart SDK 3.0+
- Firebase account
- Git
- Code editor (VS Code or Android Studio recommended)

### Setup Development Environment

1. **Fork the repository**
   ```bash
   # Fork on GitHub, then clone your fork
   git clone https://github.com/YOUR_USERNAME/EssenYemek.git
   cd EssenYemek
   ```

2. **Add upstream remote**
   ```bash
   git remote add upstream https://github.com/esN2k/EssenYemek.git
   ```

3. **Install dependencies**
   ```bash
   flutter pub get
   ```

4. **Configure Firebase**
   ```bash
   flutterfire configure --project=your-test-project
   ```

5. **Seed test data**
   ```bash
   flutter run lib/scripts/seed_database.dart
   ```

6. **Verify setup**
   ```bash
   flutter analyze
   flutter test
   ```

---

## Development Workflow

### Branch Strategy

We use a feature branch workflow:

```
main (protected)
  ↑
  └── feature/feature-name
  └── fix/bug-description
  └── docs/documentation-update
```

### Creating a Branch

```bash
# Update your local main
git checkout main
git pull upstream main

# Create feature branch
git checkout -b feature/add-favorites-system
```

### Branch Naming

- `feature/` - New features (e.g., `feature/add-favorites`)
- `fix/` - Bug fixes (e.g., `fix/order-price-calculation`)
- `docs/` - Documentation (e.g., `docs/update-readme`)
- `test/` - Test additions (e.g., `test/meal-service-coverage`)
- `refactor/` - Code refactoring (e.g., `refactor/extract-meal-card`)

---

## Coding Standards

### Dart Style Guide

Follow the [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style):

```dart
// ✅ Good
class MealService {
  static Future<List<MealsRecord>> fetchMeals({
    List<String>? dietFilters,
    int limit = 20,
  }) async {
    // Implementation
  }
}

// ❌ Bad
class meal_service {
  static Future<List<MealsRecord>> FetchMeals(List<String>? diet_filters, int Limit) async {
    // Implementation
  }
}
```

### Code Organization

1. **Group imports**:
   ```dart
   // Dart imports
   import 'dart:async';
   
   // Flutter imports
   import 'package:flutter/material.dart';
   
   // Package imports
   import 'package:provider/provider.dart';
   
   // Local imports
   import '/backend/backend.dart';
   ```

2. **Use meaningful names**:
   ```dart
   // ✅ Good
   final activePlans = plans.where((p) => p.isActive).toList();
   
   // ❌ Bad
   final p = plans.where((x) => x.isActive).toList();
   ```

3. **Keep functions small and focused**:
   ```dart
   // ✅ Good - Single responsibility
   Future<void> savePlan(PlansRecord plan) async {
     await _validatePlan(plan);
     await _persistPlan(plan);
     _notifyListeners();
   }
   
   // ❌ Bad - Too many responsibilities
   Future<void> doEverything() async {
     // 100 lines of mixed logic
   }
   ```

### Flutter Best Practices

1. **Use const constructors** where possible:
   ```dart
   const SizedBox(height: 20)
   const Text('Hello')
   ```

2. **Extract widgets** for reusability:
   ```dart
   // ✅ Good
   class MealCard extends StatelessWidget {
     final MealsRecord meal;
     const MealCard({required this.meal});
     // ...
   }
   
   // ❌ Bad - Inline complex widgets
   Widget build(BuildContext context) {
     return Column(
       children: [
         // 50 lines of meal card UI
       ],
     );
   }
   ```

3. **Null safety**:
   ```dart
   // ✅ Good
   String? userName = user?.displayName;
   
   // ❌ Bad
   String userName = user.displayName!;  // Dangerous!
   ```

---

## Commit Message Guidelines

We follow [Conventional Commits](https://www.conventionalcommits.org/):

### Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `test`: Adding or updating tests
- `refactor`: Code refactoring
- `style`: Formatting changes
- `chore`: Maintenance tasks

### Examples

```bash
# Feature
feat(meals): add favorites system
feat(orders): implement order cancellation

# Bug fix
fix(plan): correct price calculation for 3-meal plans
fix(auth): handle expired token refresh

# Documentation
docs(readme): update installation instructions
docs(api): add MealService documentation

# Tests
test(orders): add integration tests for order flow
test(plan): increase service coverage to 85%

# Refactoring
refactor(meal-card): extract loading state component
refactor(services): move filtering logic to service layer
```

### Commit Message Tips

- Use imperative mood ("add" not "added")
- Keep subject line under 50 characters
- Capitalize first letter
- No period at the end
- Explain "what" and "why", not "how"

---

## Pull Request Process

### Before Submitting

1. **Update your branch**:
   ```bash
   git fetch upstream
   git rebase upstream/main
   ```

2. **Run tests**:
   ```bash
   flutter test
   flutter analyze
   ```

3. **Update documentation** if needed

4. **Test manually**:
   - Run the app
   - Test your changes
   - Test affected features

### PR Title

Use the same format as commit messages:

```
feat(meals): add favorites system
fix(orders): correct price calculation
docs(contributing): add PR guidelines
```

### PR Description Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Changes Made
- Change 1
- Change 2

## Testing Done
- [ ] Unit tests added/updated
- [ ] Widget tests added/updated
- [ ] Integration tests added/updated
- [ ] Manual testing completed

## Screenshots (if applicable)
Add screenshots of UI changes

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex code
- [ ] Documentation updated
- [ ] No new warnings
- [ ] Tests pass locally
```

### Code Review Process

1. **Automated Checks**:
   - Tests must pass
   - No analyzer warnings
   - Code coverage maintained

2. **Human Review**:
   - At least one approving review required
   - Address all feedback
   - Update PR based on comments

3. **Merge**:
   - Squash and merge (keeps history clean)
   - Delete branch after merge

---

## Testing Requirements

### Minimum Coverage

- New backend services: 80%+
- New UI widgets: 60%+
- Bug fixes: Add regression test

### Writing Tests

**Unit Tests**:
```dart
test('fetchMeals filters by diet type', () async {
  final firestore = FakeFirebaseFirestore();
  
  // Arrange
  await _seedTestMeals(firestore);
  
  // Act
  final meals = await MealService.fetchMeals(
    firestore: firestore,
    dietFilters: ['Vegan'],
  );
  
  // Assert
  expect(meals.length, greaterThan(0));
  expect(meals.every((m) => m.mealDiet.contains('Vegan')), isTrue);
});
```

**Widget Tests**:
```dart
testWidgets('MealCard displays meal name', (tester) async {
  // Arrange
  final meal = createTestMeal(name: 'Test Meal');
  
  // Act
  await tester.pumpWidget(
    MaterialApp(home: MealCard(meal: meal)),
  );
  
  // Assert
  expect(find.text('Test Meal'), findsOneWidget);
});
```

### Running Tests

```bash
# All tests
flutter test

# Specific file
flutter test test/services/meal_service_test.dart

# With coverage
flutter test --coverage

# Integration tests
flutter test integration_test/
```

---

## Documentation

### Code Comments

**When to comment**:
- Complex algorithms
- Non-obvious decisions
- Public API methods
- Workarounds or hacks

**Example**:
```dart
/// Fetches meals from Firestore with optional filters.
///
/// [dietFilters] - List of diet types to filter by (e.g., ['Vegan', 'Vegetarian'])
/// [maxCalories] - Maximum calories per meal
/// [limit] - Maximum number of results (default: 20)
///
/// Returns a list of [MealsRecord] matching the filters.
///
/// Example:
/// ```dart
/// final meals = await MealService.fetchMeals(
///   dietFilters: ['Vegan'],
///   maxCalories: 400,
/// );
/// ```
static Future<List<MealsRecord>> fetchMeals({
  List<String>? dietFilters,
  int? maxCalories,
  int limit = 20,
}) async {
  // Implementation
}
```

### README Updates

Update README.md when:
- Adding new features
- Changing setup process
- Adding new dependencies
- Modifying build/run commands

### API Documentation

Update `docs/API_DOCUMENTATION.md` when:
- Adding new Firestore collections
- Adding new service methods
- Changing data schemas
- Modifying security rules

---

## Questions?

- **General**: Open a [Discussion](https://github.com/esN2k/EssenYemek/discussions)
- **Bugs**: Create an [Issue](https://github.com/esN2k/EssenYemek/issues)
- **Features**: Open a [Feature Request](https://github.com/esN2k/EssenYemek/issues/new?template=feature_request.md)

---

## License

By contributing, you agree that your contributions will be licensed under the same license as the project.

---

**Thank you for contributing to EssenYemek! 🍽️**
