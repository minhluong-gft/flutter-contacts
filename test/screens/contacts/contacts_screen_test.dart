import 'package:flutter/material.dart';
import 'package:flutter_contacts/models/contact.dart';
import 'package:flutter_contacts/repositories/contacts_repository.dart';
import 'package:flutter_contacts/screens/contacts/contacts_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import './contacts_screen_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ContactsRepository>()])
void main() {
  testWidgets('ContactsScreen show loading state when initial', (tester) async {
    await tester.pumpWidget(buildWrapper(const ContactsScreen()));

    final appBarTitleFinder = find.text('contacts');

    expect(appBarTitleFinder, findsOneWidget);
    expect(find.byKey(const Key('loading')), findsOneWidget);
  });

  testWidgets('ContactsScreen show empty state', (tester) async {
    final mockContactsRepository = MockContactsRepository();
    when(mockContactsRepository.getContacts())
        .thenAnswer((_) => Future.value([]));
    await tester.pumpWidget(
      buildWrapper(
        const ContactsScreen(),
        overrides: [
          contactsRepositoryProvider
              .overrideWith((ref) => mockContactsRepository),
        ],
      ),
    );

    expect(find.byKey(const Key('loading')), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('No contacts'), findsOneWidget);
  });

  testWidgets('ContactsScreen show list when success', (tester) async {
    final mockContactsRepository = MockContactsRepository();

    when(mockContactsRepository.getContacts()).thenAnswer((_) {
      return Future.value([
        const Contact(
          id: '1',
          fullName: 'John Doe',
          avatar: '',
          email: 'john.doe@gmail.com',
        ),
        const Contact(
          id: '2',
          fullName: 'John Doe',
          avatar: '',
          email: 'john.doe2@gmail.com',
        ),
      ]);
    });
    await tester.pumpWidget(
      buildWrapper(
        const ContactsScreen(),
        overrides: [
          contactsRepositoryProvider
              .overrideWith((ref) => mockContactsRepository),
        ],
      ),
    );

    expect(find.byKey(const Key('loading')), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('John Doe'), findsExactly(2));
    expect(find.text('john.doe@gmail.com'), findsOneWidget);
    expect(find.text('john.doe2@gmail.com'), findsOneWidget);
  });

  testWidgets('ContactsScreen show error if load contacts failed',
      (tester) async {
    final mockContactsRepository = MockContactsRepository();
    when(mockContactsRepository.getContacts())
        .thenThrow(Exception('Some Test Errors'));

    await tester.pumpWidget(
      buildWrapper(
        const ContactsScreen(),
        overrides: [
          contactsRepositoryProvider
              .overrideWith((ref) => mockContactsRepository),
        ],
      ),
    );

    expect(find.byKey(const Key('loading')), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('Failed to load contacts'), findsOneWidget);
    // expect(find.text('Some Test Errors'), findsOneWidget);
  });
}

Widget buildWrapper(Widget child, {List<Override>? overrides}) {
  return ProviderScope(
    overrides: overrides ?? [],
    child: MaterialApp(home: child),
  );
}
