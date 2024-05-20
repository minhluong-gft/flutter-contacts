import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_contacts/models/contact.dart'; // Adjust the import to your actual file location
import 'package:flutter_contacts/generated/proto/index.pbgrpc.dart' as grpc;

void main() {
  group('Contact', () {
    test('fromGrpcContact maps properties correctly', () {
      // Create a sample grpc.Contact object
      final grpcContact = grpc.Contact()
        ..id = '123'
        ..fullName = 'John Doe'
        ..avatar = 'avatar.png'
        ..email = 'johndoe@example.com'
        ..isFavorite = true;

      // Create a Contact instance using the factory
      final contact = Contact.fromGrpcContact(grpcContact);

      // Verify that the properties are correctly mapped
      expect(contact.id, grpcContact.id);
      expect(contact.fullName, grpcContact.fullName);
      expect(contact.avatar, grpcContact.avatar);
      expect(contact.email, grpcContact.email);
      expect(contact.isFavorite, grpcContact.isFavorite);
    });

    test('copyWith creates a copy with updated values', () {
      // Create an initial Contact instance
      const contact = Contact(
        id: '123',
        fullName: 'John Doe',
        avatar: 'avatar.png',
        email: 'johndoe@example.com',
        isFavorite: false,
      );

      // Create a copy with updated properties
      final updatedContact = contact.copyWith(
        fullName: 'Jane Doe',
        email: 'janedoe@example.com',
        isFavorite: true,
      );

      // Verify that the updated properties are correctly applied
      expect(updatedContact.id, contact.id); // unchanged
      expect(updatedContact.fullName, 'Jane Doe'); // updated
      expect(updatedContact.avatar, contact.avatar); // unchanged
      expect(updatedContact.email, 'janedoe@example.com'); // updated
      expect(updatedContact.isFavorite, true); // updated
    });

    test('copyWith retains original values when no updates are provided', () {
      // Create an initial Contact instance
      const contact = Contact(
        id: '123',
        fullName: 'John Doe',
        avatar: 'avatar.png',
        email: 'johndoe@example.com',
        isFavorite: false,
      );

      // Create a copy without providing any new values
      final copiedContact = contact.copyWith();

      // Verify that all properties remain the same
      expect(copiedContact.id, contact.id);
      expect(copiedContact.fullName, contact.fullName);
      expect(copiedContact.avatar, contact.avatar);
      expect(copiedContact.email, contact.email);
      expect(copiedContact.isFavorite, contact.isFavorite);
    });
  });
}
