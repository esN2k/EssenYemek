import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:essen_yemek/bilesenlercomp/diet_item/diet_item_widget.dart';
import 'package:essen_yemek/bilesenlercomp/preference_item/preference_item_widget.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    GoogleFonts.config.allowRuntimeFetching = false;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (message) async {
      final key = utf8.decode(message!.buffer.asUint8List());
      if (key == 'AssetManifest.json') {
        return ByteData.view(utf8.encoder.convert('{}').buffer);
      }
      return null;
    });
  });

  testWidgets('DietItemWidget shows tagline when selected', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: DietItemWidget(
            dietType: 'Balanced',
            selectedDiet: 'Balanced',
            dietTagline: 'Everyday meals',
            action: () async {
              tapped = true;
            },
          ),
        ),
      ),
    );

    expect(find.text('Balanced'), findsOneWidget);
    expect(find.text('Everyday meals'), findsOneWidget);

    await tester.tap(find.byType(InkWell));
    await tester.pump();

    expect(tapped, isTrue);
  });

  testWidgets('PreferenceItemWidget triggers action on tap', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: PreferenceItemWidget(
            text: 'Gluten',
            selectedItems: const ['Gluten'],
            action: () async {
              tapped = true;
            },
          ),
        ),
      ),
    );

    expect(find.text('Gluten'), findsOneWidget);

    await tester.tap(find.byType(InkWell));
    await tester.pump();

    expect(tapped, isTrue);
  });
}
