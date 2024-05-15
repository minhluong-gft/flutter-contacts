import 'package:flutter_contacts/generated/proto/index.pb.dart' as proto;
import 'package:flutter_contacts/services/contacts_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_contacts/models/contact.dart';

// final contactsDataProvider = FutureProvider.autoDispose((ref) async {
//   final response =
//       await ContactsService.instance.client.getContacts(proto.Void());
//   final contacts = response.contacts.map(Contact.fromProtoContact).toList();
//   return contacts;
// });

final contactsDataProvider =
    AsyncNotifierProvider.autoDispose<ContactsDataNotifier, List<Contact>>(
        ContactsDataNotifier.new);

class ContactsDataNotifier extends AutoDisposeAsyncNotifier<List<Contact>> {
  Future<void> addContact({
    required String fullName,
    required String email,
    required String? avatar,
  }) async {
    final client = ContactsService.instance.client;
    final protoContact = await client.createContact(
      proto.CreateContactRequest(
        fullName: fullName,
        email: email,
        avatar: avatar,
      ),
    );

    final newContact = Contact.fromProtoContact(protoContact);

    final previousState = await future;

    state = AsyncData([...previousState, newContact]);
  }

  @override
  Future<List<Contact>> build() async {
    final response =
        await ContactsService.instance.client.getContacts(proto.Void());
    final contacts = response.contacts.map(Contact.fromProtoContact).toList();
    return contacts;
  }
}
