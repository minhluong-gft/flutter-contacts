import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_contacts/repositories/auth_repository.dart';
import 'package:flutter_contacts/screens/login_screen.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import './login_screen_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AuthRepository>()])
void main() {
  testWidgets('Login screen should display as snapshot', (tester) async {
    await tester.pumpWidget(buildWrapper(const LoginScreen()));

    expect(find.byType(LoginScreen),
        matchesGoldenFile('snapshots/login_screen.png'));
  });

  testWidgets('Login screen login success', (tester) async {
    const username = 'user';
    const password = '123';

    final mockAuthRepository = MockAuthRepository();
    when(mockAuthRepository.login(username: username, password: password))
        .thenAnswer((_) => Future.value('some-token'));

    await tester.pumpWidget(buildWrapper(const LoginScreen(), overrides: [
      authRepositoryProvider.overrideWithValue(mockAuthRepository)
    ]));

    final usernameField = find.ancestor(
      of: find.text('username'),
      matching: find.byType(FormBuilderTextField),
    );
    await tester.enterText(usernameField, username);

    final passwordField = find.ancestor(
      of: find.text('password'),
      matching: find.byType(FormBuilderTextField),
    );
    await tester.enterText(passwordField, password);

    final loginButton = find.byKey(const Key('btn_login'));

    await tester.tap(loginButton);
    await tester.pump();

    expect(find.byKey(const Key('loader')), findsOneWidget);

    verify(mockAuthRepository.login(username: username, password: password))
        .called(1);
  });
}

Widget buildWrapper(Widget child, {List<Override>? overrides}) {
  return ProviderScope(
    overrides: overrides ?? [],
    child: MaterialApp(home: child),
  );
}
