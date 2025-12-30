import 'package:flutter/foundation.dart';

import '/backend/backend.dart';

class CompanyInformationService {
  static const String defaultDocId = 'default';
  static const String defaultName = 'EssenYemek';
  static const String defaultTermsUrl = 'https://www.essenyemek.com/terms';
  static const String defaultSupportEmail = 'support@essenyemek.com';
  static const String defaultSupportPhone = '+90 850 000 0000';
  static const String defaultAddress = 'Istanbul, Turkiye';
  static const String defaultCompanyBio =
      'Modern meal plans delivered fresh to your door.';

  static DocumentReference<Map<String, dynamic>> companyInfoDocRef({
    FirebaseFirestore? firestore,
  }) {
    final db = firestore ?? FirebaseFirestore.instance;
    return db.collection('company_information').doc(defaultDocId);
  }

  static Future<void> ensureDefaultCompanyInformation({
    FirebaseFirestore? firestore,
  }) async {
    final ref = companyInfoDocRef(firestore: firestore);
    try {
      final doc = await ref.get();
      if (doc.exists) {
        return;
      }
      await ref.set(
        createCompanyInformationRecordData(
          name: defaultName,
          email: defaultSupportEmail,
          phone: defaultSupportPhone,
          address: defaultAddress,
          companyBio: defaultCompanyBio,
          termsURL: defaultTermsUrl,
        ),
      );
    } on FirebaseException catch (error, stackTrace) {
      FlutterError.reportError(
        FlutterErrorDetails(exception: error, stack: stackTrace),
      );
    }
  }
}
