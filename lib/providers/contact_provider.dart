import 'package:flutter_contacts/generated/proto/index.pb.dart' as proto;
import 'package:flutter_contacts/models/contact.dart';
import 'package:flutter_contacts/providers/auth_provider.dart';
import 'package:flutter_contacts/services/contacts_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';

final contactProvider =
    FutureProvider.autoDispose.family<Contact, String>((ref, contactId) async {
  final credentials = ref.read(authProvider).credentials;
  final client = ContactsService.instance.client;
  final response = await client.getContact(
    proto.Id(id: contactId),
    options: CallOptions(metadata: {'authorization': 'basic $credentials'}),
  );

  final contact = Contact.fromProtoContact(response);
  return contact;
});
