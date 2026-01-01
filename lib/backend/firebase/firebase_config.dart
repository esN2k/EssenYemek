import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:logger/logger.dart';
import '/firebase_options.dart';

final _logger = Logger();

Future initFirebase() async {
  // Longer delay for web to ensure JS SDK is fully loaded and initialized
  if (kIsWeb) {
    await Future.delayed(const Duration(milliseconds: 1000));
  }

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // Log but don't fail for configuration-not-found on web
    // This can happen if the JS SDK hasn't fully initialized yet
    _logger.e('Firebase initialization error: $e');
    if (!kIsWeb) {
      rethrow;
    }
    // On web, allow it to continue as Firebase might be in process of initializing
  }
}
