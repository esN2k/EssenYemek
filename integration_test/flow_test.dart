import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:essen_yemek/app_state.dart';
import 'package:essen_yemek/flutter_flow/flutter_flow_theme.dart';
import 'package:essen_yemek/flutter_flow/internationalization.dart';
import 'package:essen_yemek/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    GoogleFonts.config.allowRuntimeFetching = true;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (message) async {
      final key = utf8.decode(message!.buffer.asUint8List());
      if (key == 'AssetManifest.json') {
        return ByteData.view(utf8.encoder.convert('{}').buffer);
      }
      return null;
    });
    SharedPreferences.setMockInitialValues({});
    await FlutterFlowTheme.initialize();
    await FFLocalizations.initialize();
  });

  setUp(() {
    FFAppState.reset();
  });

  testWidgets('plan to orders navigation shows empty state',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => FFAppState(),
        child: const MaterialApp(
          localizationsDelegates: [
            FFLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            FallbackMaterialLocalizationDelegate(),
            FallbackCupertinoLocalizationDelegate(),
          ],
          supportedLocales: [
            Locale('tr'),
            Locale('en'),
          ],
          locale: Locale('en'),
          home: NavBarPage(initialPage: 'Plan'),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Your plan'), findsOneWidget);

    await tester.tap(find.text('Orders'));
    await tester.pumpAndSettle();

    expect(find.text('Please sign in to view your orders.'), findsOneWidget);
  });
}
