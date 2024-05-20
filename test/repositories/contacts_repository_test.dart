// test/contacts_repository_test.dart
import 'package:flutter_contacts/models/contact.dart';
import 'package:flutter_contacts/repositories/contacts_repository.dart';
import 'package:flutter_contacts/generated/proto/index.pbgrpc.dart' as grpc;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import './contacts_repository_test.mocks.dart';
import '../mock_response_future.dart';

@GenerateMocks([grpc.ContactsClient])
void main() {
  late ContactsRepository repository;
  late MockContactsClient mockClient;

  setUp(() {
    mockClient = MockContactsClient();
    repository =
        ContactsRepository(client: mockClient, credentials: 'test_credentials');
  });

  group('ContactsRepository', () {
    test('getContacts returns list of contacts', () async {
      final mockResponse = grpc.ContactsResponse(contacts: [
        grpc.Contact(fullName: 'John Doe', email: 'john@example.com'),
      ]);

      when(mockClient.getContacts(any, options: anyNamed('options')))
          .thenAnswer((_) => MockResponseFuture(mockResponse));

      final contacts = await repository.getContacts();

      expect(contacts, isA<List<Contact>>());
      expect(contacts.length, 1);
      expect(contacts.first.fullName, 'John Doe');
    });

    test('getContact returns a contact', () async {
      final mockResponse =
          grpc.Contact(fullName: 'John Doe', email: 'john@example.com');

      when(mockClient.getContact(any, options: anyNamed('options')))
          .thenAnswer((_) => MockResponseFuture(mockResponse));

      final contact = await repository.getContact('1');

      expect(contact, isA<Contact>());
      expect(contact.fullName, 'John Doe');
    });

    test('addContact adds a new contact', () async {
      final mockResponse =
          grpc.Contact(fullName: 'John Doe', email: 'john@example.com');

      when(mockClient.createContact(any, options: anyNamed('options')))
          .thenAnswer((_) => MockResponseFuture(mockResponse));

      final newContact = await repository.addContact(
        fullName: 'John Doe',
        email: 'john@example.com',
        avatar: 'avatar.png',
      );

      expect(newContact, isA<Contact>());
      expect(newContact.fullName, 'John Doe');
    });

    test('deleteContact deletes a contact', () async {
      when(mockClient.deleteContact(any, options: anyNamed('options')))
          .thenAnswer((_) => MockResponseFuture(grpc.Void()));

      await repository.deleteContact('1');

      verify(mockClient.deleteContact(any, options: anyNamed('options')))
          .called(1);
    });

    // test('setContactFavorite sets a contact as favorite', () async {
    //   when(mockClient.setContactFavorite(any, options: anyNamed('options')))
    //       .thenAnswer((_) => MockResponseFuture(grpc.Void()));
    //       .thenAnswer((_) async => grpc.Void());

    //   await repository.setContactFavorite('1', true);

    //   verify(mockClient.setContactFavorite(any, options: anyNamed('options')))
    //       .called(1);
    // });

    // test('_buildCallOptions returns proper CallOptions', () {
    //   final options = repository._buildCallOptions();

    //   expect(options.metadata!['authorization'], 'basic test_credentials');
    // });
  });
}
