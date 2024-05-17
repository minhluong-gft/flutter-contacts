import 'package:flutter_contacts/generated/proto/index.pb.dart' as proto;
import 'package:flutter_contacts/providers/auth_provider.dart';
import 'package:flutter_contacts/providers/contact_provider.dart';
import 'package:flutter_contacts/services/contacts_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_contacts/models/contact.dart';
import 'package:grpc/grpc.dart';

final contactsProvider =
    AsyncNotifierProvider.autoDispose<ContactsNotifier, List<Contact>>(
        ContactsNotifier.new);

class ContactsNotifier extends AutoDisposeAsyncNotifier<List<Contact>> {
  Future<void> addContact({
    required String fullName,
    required String email,
    required String? avatar,
  }) async {
    final credentials = ref.read(authProvider).credentials;
    final client = ContactsService.instance.client;
    final protoContact = await client.createContact(
      proto.CreateContactRequest(
        fullName: fullName,
        email: email,
        avatar: avatar,
      ),
      options: CallOptions(metadata: {'authorization': 'basic $credentials'}),
    );

    final newContact = Contact.fromProtoContact(protoContact);

    final previousState = await future;

    state = AsyncData([...previousState, newContact]);
  }

  Future<void> deleteContact(String contactId) async {
    final credentials = ref.read(authProvider).credentials;
    final client = ContactsService.instance.client;
    await client.deleteContact(
      proto.Id(id: contactId),
      options: CallOptions(metadata: {'authorization': 'basic $credentials'}),
    );

    final previousState = await future;
    state = AsyncData(
        previousState.where((element) => element.id != contactId).toList());
  }

  Future<void> setContactFavorite(String contactId, bool isFavorite) async {
    final credentials = ref.read(authProvider).credentials;
    final client = ContactsService.instance.client;
    await client.setContactFavorite(
      proto.SetContactFavoriteRequest(id: contactId, isFavorite: isFavorite),
      options: CallOptions(metadata: {'authorization': 'basic $credentials'}),
    );

    final previousState = await future;
    state = AsyncData(previousState.map((element) {
      if (element.id != contactId) {
        return element;
      }
      return element.copyWith(isFavoriteParameter: isFavorite);
    }).toList());

    ref.invalidate(contactProvider(contactId));
  }

  @override
  Future<List<Contact>> build() async {
    final credentials = ref.read(authProvider).credentials;
    final response = await ContactsService.instance.client.getContacts(
      proto.Void(),
      options: CallOptions(metadata: {'authorization': 'basic $credentials'}),
    );
    final contacts = response.contacts.map(Contact.fromProtoContact).toList();
    return contacts;
  }
}
