import 'package:flutter_contacts/models/contact.dart';
import 'package:flutter_contacts/repositories/contacts_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contactProvider = FutureProvider.autoDispose.family<Contact, String>(
  (ref, contactId) async {
    final contactsRepository = ref.watch(contactsRepositoryProvider);
    final contact = await contactsRepository.getContact(contactId);
    return contact;
  },
);
