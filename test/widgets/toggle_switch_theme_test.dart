import 'package:flutter/material.dart';
import 'package:flutter_contacts/widgets/toggle_switch_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  SharedPreferences.setMockInitialValues({"isLightTheme": true});

  setUpAll(() async {
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('displays the switch with correct initial state',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: EasyLocalization(
          supportedLocales: const [Locale('en', 'US')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en', 'US'),
          child: const MaterialApp(
            home: Scaffold(
              body: ToggleSwitchTheme(),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify the initial state of the switch
    expect(find.byType(SwitchListTile), findsOneWidget);

    final switchFinder = find.byType(SwitchListTile);
    final SwitchListTile switchListTile = tester.widget(switchFinder);
    expect(switchListTile.value, isTrue);
  });

  testWidgets('toggles the switch and updates the theme state',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: EasyLocalization(
          supportedLocales: const [Locale('en', 'US')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en', 'US'),
          child: const MaterialApp(
            home: Scaffold(
              body: ToggleSwitchTheme(),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final switchFinder = find.byType(SwitchListTile);
    await tester.tap(switchFinder);
    await tester.pump();

    final SwitchListTile switchListTile = tester.widget(switchFinder);
    expect(switchListTile.value, false);
  });
}
