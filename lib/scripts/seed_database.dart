// Seed script for EssenYemek database
// This script populates the Firestore database with sample meal data
//
// Usage:
//   flutter run lib/scripts/seed_database.dart

import 'package:firebase_core/firebase_core.dart';
import 'package:logger/logger.dart';
import '../backend/meal_service.dart';
import '../firebase_options.dart';

final _logger = Logger();

void main() async {
  _logger.i('🌱 Starting database seed...');

  try {
    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _logger.i('✅ Firebase initialized');

    // Seed meals
    _logger.i('📦 Seeding meals...');
    await MealService.seedSampleMeals();
    _logger.i('✅ Meals seeded successfully!');

    _logger.i('🎉 Database seed completed successfully!');
    _logger.i('You can now use the app with sample meal data.');
  } catch (e, stackTrace) {
    _logger.e('❌ Error seeding database: $e', stackTrace: stackTrace);
  }
}
