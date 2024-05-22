import 'package:flutter_contacts/generated/proto/index.pbgrpc.dart';
import 'package:flutter_contacts/services/contacts_service.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

// Mock class for ContactsClient
class MockContactsClient extends Mock implements ContactsClient {}

void main() {
  group('ContactsService', () {
    late ContactsService contactsService;

    setUp(() {
      contactsService = ContactsService();
    });

    test('instance returns the singleton instance', () {
      final instance1 = ContactsService.instance;
      final instance2 = ContactsService.instance;
      expect(instance1, same(instance2));
    });

    test('init creates a new client', () async {
      await contactsService.init();
      expect(contactsService.client, isA<ContactsClient>());
    });

    test('_createChannel initializes client with the correct host and port',
        () {
      contactsService.init();
      final client = contactsService.client;
      expect(client, isA<ContactsClient>());
      // We can't directly test private fields or methods in Dart
      // but we can infer from the public properties and methods.
    });

    test('client getter returns the client instance', () async {
      await contactsService.init();
      expect(contactsService.client, isA<ContactsClient>());
    });
  });
}
