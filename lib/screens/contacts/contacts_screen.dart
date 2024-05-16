import 'package:flutter/material.dart';
import 'package:flutter_contacts/providers/theme_provider.dart';
import 'package:flutter_contacts/screens/contacts/favorite_contact_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_contacts/models/contact.dart';
import 'package:flutter_contacts/providers/contacts_provider.dart';
import 'package:flutter_contacts/screens/contacts/contacts_list.dart';
import 'package:flutter_contacts/widgets/new_contact_form.dart';

class ContactsScreen extends ConsumerWidget {
  const ContactsScreen({super.key});

  void _handleAddContact(BuildContext context, WidgetRef ref) async {
    final Contact? newContact = await showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => Padding(
        // padding: const EdgeInsets.all(20),
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: const NewContactForm(),
      ),
    );

    if (newContact != null) {
      ref.read(contactsProvider.notifier).addContact(newContact);
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    final contacts = ref.watch(contactsProvider);
    final isLightTheme = ref.watch(themProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Contacts')),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FavoriteContactList(),
            Expanded(
              child: contacts.isEmpty
                  ? const Center(child: Text('No contacts'))
                  : ContactsList(contacts: contacts),
            ),
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _handleAddContact(context, ref),
        child: const Icon(Icons.add),
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SwitchListTile(
                  title: const Text("Light Mode"),
                  value: isLightTheme,
                  onChanged: (value) {
                    ref.read(themProvider.notifier).state = value;
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
