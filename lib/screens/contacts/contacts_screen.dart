import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/screens/contacts/favorite_contact_list.dart';
import 'package:flutter_contacts/providers/contacts_provider.dart';
import 'package:flutter_contacts/widgets/main_draw.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_contacts/models/contact.dart';
import 'package:flutter_contacts/screens/contacts/contacts_list.dart';
import 'package:flutter_contacts/widgets/new_contact_form.dart';

class ContactsScreen extends ConsumerWidget {
  const ContactsScreen({super.key});

  void _handleAddContact(BuildContext context, WidgetRef ref) async {
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: const NewContactForm(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, ref) {
    final contactsAsyncValue = ref.watch(contactsProvider);

    final Widget body;

    if (contactsAsyncValue.value != null && contactsAsyncValue.value!.isEmpty) {
      body = _buildEmptyState(context);
    } else if (contactsAsyncValue.valueOrNull != null) {
      body = _buildList(contactsAsyncValue.value!, ref);
    } else if (contactsAsyncValue.error != null) {
      body = _buildError(contactsAsyncValue.error.toString(), context);
    } else {
      body = _buildLoadingState();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('contacts').tr()),
      body: body,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _handleAddContact(context, ref),
        child: const Icon(Icons.add),
      ),
      drawer: const MainDrawer(),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
        key: Key('loading'), child: CircularProgressIndicator());
  }

  Widget _buildError(String error, BuildContext context) {
    final theme = Theme.of(context);
    return _buildRefreshIndicator(Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Failed to load contacts',
            style: TextStyle(color: theme.colorScheme.onSurface),
          ),
          const SizedBox(height: 16),
          Text(
            error,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall!
                .copyWith(color: theme.colorScheme.onSurface),
          ),
        ],
      ),
    ));
  }

  Widget _buildEmptyState(BuildContext context) {
    return _buildRefreshIndicator(
      Center(
        child: Text(
          'No contacts',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
    );
  }

  Widget _buildList(List<Contact> contacts, WidgetRef ref) {
    final favoriteContacts =
        contacts.where((contact) => contact.isFavorite).toList();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (favoriteContacts.isNotEmpty) ...[
          FavoriteContactList(favoriteContacts),
          const Divider(height: 1),
        ],
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => ref.refresh(contactsProvider.future),
            child: ContactsList(contacts: contacts),
          ),
        ),
      ],
    );
  }

  Widget _buildRefreshIndicator(Widget child) {
    return Consumer(
      builder: (ctx, ref, widget) => RefreshIndicator(
        onRefresh: () => ref.refresh(contactsProvider.future),
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: constraints.maxHeight,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
