import 'package:flutter/material.dart';
import 'package:flutter_contacts/providers/contacts_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_contacts/models/contact.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';

class ContactsList extends ConsumerWidget {
  const ContactsList({
    super.key,
    required this.contacts,
  });

  final List<Contact> contacts;

  void _deleteContact(
      Contact contact, WidgetRef ref, BuildContext context) async {
    await ref.read(contactsProvider.notifier).deleteContact(contact.id);

    if (context.mounted) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 6),
          content: Text("Deleted ${contact.fullName}"),
        ),
      );
    }
  }

  void _toggleFavorite(Contact contact, WidgetRef ref) {
    final newIsFavorite = !contact.isFavorite;
    ref
        .read(contactsProvider.notifier)
        .setContactFavorite(contact.id, newIsFavorite);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      itemCount: contacts.length,
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(height: 1),
      itemBuilder: (ctx, index) {
        final contact = contacts[index];
        return Slidable(
          key: ValueKey(contact.id),
          useTextDirection: true,
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                key: Key('icon-favorite-${contact.id}'),
                onPressed: (ctx) {
                  _toggleFavorite(contact, ref);
                },
                foregroundColor: contact.isFavorite
                    ? Colors.orange
                    : Theme.of(context).colorScheme.onTertiaryContainer,
                backgroundColor:
                    Theme.of(context).colorScheme.tertiaryContainer,
                icon: contact.isFavorite ? Icons.star : Icons.star_outline,
              ),
              SlidableAction(
                key: Key('icon-delete-${contact.id}'),
                autoClose: false,
                onPressed: (ctx) {
                  final controller = Slidable.of(ctx);
                  controller!.dismiss(
                    ResizeRequest(const Duration(milliseconds: 200), () {
                      _deleteContact(contact, ref, context);
                    }),
                    duration: const Duration(milliseconds: 200),
                  );
                },
                foregroundColor: Theme.of(context).colorScheme.onErrorContainer,
                backgroundColor: Theme.of(context).colorScheme.errorContainer,
                icon: Icons.delete,
              ),
            ],
          ),
          child: ListTile(
            onTap: () {
              context.pushNamed('contactDetails',
                  pathParameters: {'contactId': contact.id});
            },
            leading: contact.avatar != null && contact.avatar!.isNotEmpty
                ? CircleAvatar(backgroundImage: NetworkImage(contact.avatar!))
                : const CircleAvatar(
                    foregroundImage:
                        AssetImage('assets/images/default_avatar.jpg')),
            title: Text(contact.fullName),
            subtitle: Text(contact.email),
          ),
        );
      },
    );
  }
}
