import 'package:flutter/material.dart';
import 'package:flutter_contacts/providers/theme_provider.dart';
import 'package:flutter_contacts/screens/contacts/favorite_contact_list.dart';
import 'package:flutter_contacts/generated/proto/index.pbgrpc.dart' as proto;
import 'package:flutter_contacts/services/contacts_service.dart';
import 'package:flutter_contacts/providers/contacts_data_provider.dart';
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
    final isLightTheme = ref.watch(themProvider);
    final contactsFuture = ref.watch(contactsDataProvider);

    final Widget body;

    if (contactsFuture.isLoading) {
      body = _buildLoadingState();
    } else if (contactsFuture.hasError) {
      body = _buildError(contactsFuture.error.toString(), context);
    } else if (contactsFuture.valueOrNull == null) {
      body = _buildEmptyState();
    } else {
      body = _buildList(contactsFuture.value!);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Contacts')),
      body: body,
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

  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildError(String error, BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Failed to load contacts'),
          Text(error, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(child: Text('No contacts'));
  }

  Widget _buildList(List<Contact> contacts) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: ContactsList(contacts: contacts)),
      ],
    );
  }
}
