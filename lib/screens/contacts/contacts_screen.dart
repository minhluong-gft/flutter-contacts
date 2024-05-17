import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/providers/language_provider.dart';
import 'package:flutter_contacts/providers/theme_provider.dart';
import 'package:flutter_contacts/screens/contacts/favorite_contact_list.dart';
import 'package:flutter_contacts/providers/contacts_provider.dart';
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
    final isLightTheme = ref.watch(themeNotifierProvider);

    final contactsAsyncValue = ref.watch(contactsProvider);
    Locale currentLocale = Localizations.localeOf(context);

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
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            children: [
              SwitchListTile(
                title: const Text("lightMode").tr(),
                value: isLightTheme,
                onChanged: (value) {
                  ref.read(themeNotifierProvider.notifier).toggleTheme();
                },
                contentPadding: const EdgeInsets.all(16),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "language",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ).tr(),
                    DropdownButton(
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                      items: const [
                        DropdownMenuItem(
                          value: Locale('en', 'US'),
                          child: Text('English'),
                        ),
                        DropdownMenuItem(
                          value: Locale('km', "KH"),
                          child: Text('ខ្មែរ'),
                        ),
                      ],
                      value: currentLocale,
                      onChanged: (value) {
                        ref
                            .read(languageNotifierProvider.notifier)
                            .setLanguage(value!);
                        context.setLocale(value);
                      },
                    ),
                  ],
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
