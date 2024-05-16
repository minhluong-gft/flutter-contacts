import 'package:flutter/material.dart';
import 'package:flutter_contacts/models/contact.dart';
import 'package:flutter_contacts/providers/contact_provider.dart';
import 'package:flutter_contacts/providers/contacts_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactDetailsScreen extends ConsumerWidget {
  final String contactId;
  const ContactDetailsScreen(this.contactId, {super.key});

  void _toggleFavorite(Contact contact, WidgetRef ref) {
    final newIsFavorite = !contact.isFavorite;
    ref
        .read(contactsProvider.notifier)
        .setContactFavorite(contact.id, newIsFavorite);
  }

  @override
  Widget build(BuildContext context, ref) {
    final contactAsyncValue = ref.watch(contactProvider(contactId));

    Widget body = _buildLoadingState();
    if (contactAsyncValue.hasValue) {
      body = _buildContent(contactAsyncValue.value!, context);
    }

    return Scaffold(
      appBar: _buildAppBar(contactAsyncValue.valueOrNull, context, ref),
      body: body,
    );
  }

  AppBar _buildAppBar(Contact? contact, BuildContext context, WidgetRef ref) {
    if (contact == null) {
      return AppBar();
    }
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark ? Colors.yellow : Colors.orange;
    return AppBar(
      actions: [
        IconButton(
          onPressed: () {
            _toggleFavorite(contact, ref);
          },
          icon: Icon(
            contact.isFavorite ? Icons.star : Icons.star_outline,
            color: contact.isFavorite ? iconColor : null,
          ),
        )
      ],
    );
  }

  Widget _buildContent(Contact contact, BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Image(
              image: contact.avatar != null
                  ? NetworkImage(contact.avatar!)
                  : const AssetImage('assets/images/default_avatar.jpg')
                      as ImageProvider,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned(
              height: 200,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(1),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    contact.fullName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        Text(
          contact.email,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18, color: Theme.of(context).colorScheme.onSurface),
        )
      ],
    );
  }

  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }
}
