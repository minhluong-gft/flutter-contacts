import 'package:flutter_contacts/models/contact.dart';
import 'package:flutter_contacts/providers/contact_provider.dart';
import 'package:flutter_contacts/repositories/contacts_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'contacts_provider.g.dart';

@riverpod
class Contacts extends _$Contacts {
  Future<void> addContact({
    required String fullName,
    required String email,
    required String? avatar,
  }) async {
    final newContact = await ref.read(contactsRepositoryProvider).addContact(
          fullName: fullName,
          email: email,
          avatar: avatar,
        );

    final previousState = await future;

    state = AsyncData([...previousState, newContact]);
  }

  Future<void> deleteContact(String contactId) async {
    await ref.read(contactsRepositoryProvider).deleteContact(contactId);

    final previousState = await future;
    state = AsyncData(
        previousState.where((element) => element.id != contactId).toList());
  }

  Future<void> setContactFavorite(String contactId, bool isFavorite) async {
    await ref
        .read(contactsRepositoryProvider)
        .setContactFavorite(contactId, isFavorite);

    final previousState = await future;
    state = AsyncData(previousState.map((element) {
      if (element.id != contactId) {
        return element;
      }
      return element.copyWith(isFavorite: isFavorite);
    }).toList());

    ref.invalidate(contactProvider(contactId));
  }

  @override
  Future<List<Contact>> build() async {
    final contacts = await ref.read(contactsRepositoryProvider).getContacts();
    return contacts;
  }
}
