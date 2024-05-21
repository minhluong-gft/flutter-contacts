import 'package:flutter/material.dart';
import 'package:flutter_contacts/models/contact.dart';
import 'package:flutter_contacts/repositories/contacts_repository.dart';
import 'package:flutter_contacts/screens/contacts/contacts_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'contacts_list_test.mocks.dart';

final mockContacts = [
  const Contact(
    id: '1',
    fullName: 'John Doe',
    email: 'john@example.com',
    avatar: '',
    isFavorite: false,
  ),
  const Contact(
    id: '2',
    fullName: 'Jane Doe',
    email: 'jane@example.com',
    avatar: '',
    isFavorite: true,
  )
];

@GenerateNiceMocks([MockSpec<ContactsRepository>()])
void main() {
  group('Contacts List', () {
    testWidgets('swipe item show favorite and delete options', (tester) async {
      await tester
          .pumpWidget(buildWrapper(ContactsList(contacts: mockContacts)));

      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('Jane Doe'), findsOneWidget);

      expect(find.byKey(const Key('2')), findsOneWidget);

      expect(find.byKey(const Key('icon-favorite-2')), findsNothing);
      expect(find.byKey(const Key('icon-favorite-2')), findsNothing);

      await tester.drag(find.byKey(const Key('2')), const Offset(-500, 0));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('icon-favorite-2')), findsOneWidget);
      expect(find.byKey(const Key('icon-delete-2')), findsOneWidget);
    });

    testWidgets('delete item', (tester) async {
      final mockContactsRepository = MockContactsRepository();
      when(mockContactsRepository.deleteContact('2'))
          .thenAnswer((_) => Future.value());

      await tester.pumpWidget(
          buildWrapper(ContactsList(contacts: mockContacts), overrides: [
        contactsRepositoryProvider.overrideWithValue(mockContactsRepository),
      ]));

      expect(find.byKey(const Key('2')), findsOneWidget);

      await tester.drag(find.byKey(const Key('2')), const Offset(-500, 0));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('icon-delete-2')), findsOneWidget);

      await tester.tap(find.byKey(const Key('icon-delete-2')));
      await tester.pumpAndSettle();

      verify(mockContactsRepository.deleteContact('2')).called(1);
    });

    testWidgets('set item favorite', (tester) async {
      final mockContactsRepository = MockContactsRepository();
      when(mockContactsRepository.setContactFavorite('1', true))
          .thenAnswer((_) => Future.value());
      when(mockContactsRepository.setContactFavorite('2', false))
          .thenAnswer((_) => Future.value());

      await tester.pumpWidget(
          buildWrapper(ContactsList(contacts: mockContacts), overrides: [
        contactsRepositoryProvider.overrideWithValue(mockContactsRepository),
      ]));

      expect(find.byKey(const Key('2')), findsOneWidget);

      await tester.drag(find.byKey(const Key('2')), const Offset(-500, 0));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('icon-favorite-2')), findsOneWidget);

      await tester.tap(find.byKey(const Key('icon-favorite-2')));

      verify(mockContactsRepository.setContactFavorite('2', false)).called(1);
    });
  });
}

Widget buildWrapper(Widget child, {List<Override>? overrides}) {
  return ProviderScope(
    overrides: overrides ?? [],
    child: MaterialApp(
        home: Scaffold(
      body: child,
    )),
  );
}
