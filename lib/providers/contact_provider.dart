import 'package:flutter_contacts/generated/proto/index.pb.dart' as proto;
import 'package:flutter_contacts/models/contact.dart';
import 'package:flutter_contacts/services/contacts_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contactProvider = AsyncNotifierProvider.autoDispose
    .family<ContactNotifier, Contact, String>(ContactNotifier.new);

class ContactNotifier extends AutoDisposeFamilyAsyncNotifier<Contact, String> {
  @override
  Future<Contact> build(String contactId) async {
    final client = ContactsService.instance.client;
    final response = await client.getContact(proto.Id(id: contactId));

    final contact = Contact.fromProtoContact(response);
    return contact;
  }
}
