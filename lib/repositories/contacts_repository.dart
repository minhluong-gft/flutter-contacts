import 'package:flutter_contacts/generated/proto/index.pbgrpc.dart' as grpc;
import 'package:flutter_contacts/models/contact.dart';
import 'package:flutter_contacts/providers/auth_provider.dart';
import 'package:flutter_contacts/services/contacts_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';

class ContactsRepository {
  final String? _credentials;
  final grpc.ContactsClient _client;

  ContactsRepository({required grpc.ContactsClient client, String? credentials})
      : _client = client,
        _credentials = credentials;

  Future<List<Contact>> getContacts() async {
    final response = await _client.getContacts(
      grpc.Void(),
      options: _buildCallOptions(),
    );
    final contacts = response.contacts.map(Contact.fromGrpcContact).toList();
    return contacts;
  }

  Future<Contact> getContact(String contactId) async {
    final response = await _client.getContact(
      grpc.Id(id: contactId),
      options: _buildCallOptions(),
    );

    final contact = Contact.fromGrpcContact(response);
    return contact;
  }

  Future<Contact> addContact(
      {required String fullName, required String email, String? avatar}) async {
    final response = await _client.createContact(
      grpc.CreateContactRequest(
        fullName: fullName,
        email: email,
        avatar: avatar,
      ),
      options: _buildCallOptions(),
    );

    final newContact = Contact.fromGrpcContact(response);
    return newContact;
  }

  Future<void> deleteContact(String contactId) async {
    await _client.deleteContact(
      grpc.Id(id: contactId),
      options: _buildCallOptions(),
    );
  }

  Future<void> setContactFavorite(String contactId, bool isFavorite) async {
    await _client.setContactFavorite(
      grpc.SetContactFavoriteRequest(id: contactId, isFavorite: isFavorite),
      options: _buildCallOptions(),
    );
  }

  _buildCallOptions() {
    if (_credentials == null) {
      return CallOptions();
    }
    return CallOptions(metadata: {'authorization': 'basic $_credentials'});
  }
}

final contactsRepositoryProvider = Provider<ContactsRepository>(
  (ref) {
    final credentials = ref.watch(authProvider).credentials;
    return ContactsRepository(
      client: ContactsService.instance.client,
      credentials: credentials,
    );
  },
);
