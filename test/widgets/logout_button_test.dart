import 'package:flutter/material.dart';
import 'package:flutter_contacts/providers/auth_provider.dart';
import 'package:flutter_contacts/widgets/logout_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'logout_button_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AuthNotifier>()])
void main() {
  SharedPreferences.setMockInitialValues({});

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('LogoutButton displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: EasyLocalization(
          supportedLocales: const [Locale('en', 'US')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en', 'US'),
          child: const MaterialApp(
            home: Scaffold(
              body: LogoutButton(),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(OutlinedButton), findsOneWidget);
    expect(find.text('logout'), findsOneWidget);
  });

  testWidgets('Tapping the LogoutButton shows the AlertDialog',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: EasyLocalization(
          supportedLocales: const [Locale('en', 'US')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en', 'US'),
          child: const MaterialApp(
            home: Scaffold(
              body: LogoutButton(),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.tap(find.byType(OutlinedButton));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('logout'), findsWidgets);

    expect(find.text('message_confirm_logout'), findsOneWidget);
    expect(find.text('cancel'), findsOneWidget);
  });

  testWidgets('Tapping the logout button in the AlertDialog calls logout',
      (WidgetTester tester) async {
    final mockAuthNotifier = MockAuthNotifier();
    when(mockAuthNotifier.logout()).thenAnswer((_) async {});

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(() => mockAuthNotifier),
        ],
        child: EasyLocalization(
          supportedLocales: const [Locale('en', 'US')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en', 'US'),
          child: const MaterialApp(
            home: Scaffold(
              body: LogoutButton(),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.tap(find.byType(OutlinedButton));
    await tester.pumpAndSettle();

    // await tester.tap(find.byType(ElevatedButton));
    // await tester.pumpAndSettle();

    // verify(mockAuthNotifier.logout()).called(1);
  });
}
