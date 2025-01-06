import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBDYSF21Y61rdLH42jxRgXeUceGaDxmAYQ",
            authDomain: "essen-yemek-79lvwr.firebaseapp.com",
            projectId: "essen-yemek-79lvwr",
            storageBucket: "essen-yemek-79lvwr.firebasestorage.app",
            messagingSenderId: "188409565395",
            appId: "1:188409565395:web:41f756cf62982d98fe0426"));
  } else {
    await Firebase.initializeApp();
  }
}
