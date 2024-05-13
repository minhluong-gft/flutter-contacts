import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_contacts/data/dummy_data.dart';
import 'package:flutter_contacts/models/contact.dart';

// final contactsProvider = Provider((ref) => contactsList);

class ContactsNotifier extends Notifier<List<Contact>> {
  final List<Contact> initialContacts;

  ContactsNotifier(this.initialContacts);

  @override
  List<Contact> build() {
    return initialContacts;
  }

  Function() removeContact(Contact contact) {
    final oldState = state;
    state = oldState.where((element) => contact.id != element.id).toList();

    void undoDelete() {
      state = oldState;
    }

    return undoDelete;
  }

  void addContact(Contact contact, {int? atIndex}) {
    final index = atIndex ?? state.length;

    state = List.of(state)..insert(index, contact);
  }
}

final contactsProvider = NotifierProvider<ContactsNotifier, List<Contact>>(
  () => ContactsNotifier(contactsList),
);
