import 'package:flutter/material.dart';
import 'package:flutter_contacts/providers/language_provider.dart';
import 'package:flutter_contacts/widgets/switch_langue.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'switch_language_test.mocks.dart';

@GenerateMocks([LanguageNotifier])
void main() {
  SharedPreferences.setMockInitialValues({});

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('SwitchLanguage displays correctly', (WidgetTester tester) async {
    final mockLanguageNotifier = MockLanguageNotifier();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          languageNotifierProvider.overrideWith((ref) => mockLanguageNotifier),
        ],
        child: EasyLocalization(
          supportedLocales: const [Locale('en', 'US')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en', 'US'),
          child: const MaterialApp(
            home: Scaffold(
              body: SwitchLanguage(),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text("language"), findsOneWidget);
    expect(find.byType(DropdownButton<Locale>), findsOneWidget);
  });

  testWidgets('SwitchLanguage sets language when dropdown value changes',
      (WidgetTester tester) async {
    final mockLanguageNotifier = MockLanguageNotifier();
    when(mockLanguageNotifier.setLanguage(any))
        .thenAnswer((_) async => Future.value());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          languageNotifierProvider.overrideWith((ref) => mockLanguageNotifier),
        ],
        child: EasyLocalization(
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('vi', 'VN'),
            Locale('km', 'KH')
          ],
          path: 'assets/translations',
          fallbackLocale: const Locale('en', 'US'),
          child: const MaterialApp(
            home: Scaffold(
              body: SwitchLanguage(),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Tap on the dropdown and select a new language
    await tester.tap(find.byType(DropdownButton<Locale>));
    await tester.pump();

    await tester.tap(find.text('Tiếng Việt').last);
    await tester.pump();

    verify(mockLanguageNotifier.setLanguage(const Locale('vi', 'VN')))
        .called(1);
  });
}
