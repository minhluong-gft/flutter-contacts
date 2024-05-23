import 'package:flutter_contacts/models/contact.dart';
import 'package:flutter_contacts/repositories/contacts_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'contact_provider.g.dart';

@riverpod
Future<Contact> contact(ContactRef ref, String contactId) async {
  final contactsRepository = ref.watch(contactsRepositoryProvider);
  final contact = await contactsRepository.getContact(contactId);
  return contact;
}
