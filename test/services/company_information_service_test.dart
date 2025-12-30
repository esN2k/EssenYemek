import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:essen_yemek/backend/company_information_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('ensureDefaultCompanyInformation creates default document', () async {
    final firestore = FakeFirebaseFirestore();

    await CompanyInformationService.ensureDefaultCompanyInformation(
      firestore: firestore,
    );

    final doc = await firestore
        .collection('company_information')
        .doc(CompanyInformationService.defaultDocId)
        .get();

    expect(doc.exists, isTrue);
    expect(doc.data()!['termsURL'], CompanyInformationService.defaultTermsUrl);
    expect(doc.data()!['name'], CompanyInformationService.defaultName);
  });

  test('ensureDefaultCompanyInformation keeps existing data', () async {
    final firestore = FakeFirebaseFirestore();
    await firestore
        .collection('company_information')
        .doc(CompanyInformationService.defaultDocId)
        .set({'name': 'Custom'});

    await CompanyInformationService.ensureDefaultCompanyInformation(
      firestore: firestore,
    );

    final doc = await firestore
        .collection('company_information')
        .doc(CompanyInformationService.defaultDocId)
        .get();

    expect(doc.data()!['name'], 'Custom');
  });
}
