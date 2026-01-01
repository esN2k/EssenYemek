import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:logger/logger.dart';
import '/firebase_options.dart';

final _logger = Logger();

Future initFirebase() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _logger.i('Firebase initialized successfully');

    // Web platformunda Auth persistence'ı ayarla
    if (kIsWeb) {
      try {
        // Web için session persistence kullan - bu bazı config hatalarını önler
        await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
        _logger.i('Firebase Auth persistence set to LOCAL');
      } catch (e) {
        _logger.w('Could not set Firebase Auth persistence: $e');
        // Persistence hatası kritik değil, devam et
      }
    }
  } catch (e) {
    _logger.e('Firebase initialization error: $e');
    rethrow;
  }
}
