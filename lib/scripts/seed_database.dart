// Seed script for EssenYemek database
// This script populates the Firestore database with sample meal data
//
// Usage:
//   flutter run lib/scripts/seed_database.dart

import 'package:firebase_core/firebase_core.dart';
import '../backend/meal_service.dart';
import '../firebase_options.dart';

void main() async {
  print('🌱 Starting database seed...\n');

  try {
    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('✅ Firebase initialized\n');

    // Seed meals
    print('📦 Seeding meals...');
    await MealService.seedSampleMeals();
    print('✅ Meals seeded successfully!\n');

    print('🎉 Database seed completed successfully!');
    print('You can now use the app with sample meal data.\n');
  } catch (e, stackTrace) {
    print('❌ Error seeding database: $e');
    print('Stack trace: $stackTrace');
  }
}
