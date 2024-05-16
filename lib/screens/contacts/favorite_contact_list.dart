import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_contacts/models/contact.dart';

class FavoriteContactList extends ConsumerWidget {
  const FavoriteContactList(this.favoriteContacts, {super.key});
  final List<Contact> favoriteContacts;

  @override
  Widget build(BuildContext context, ref) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Favorites",
            style: theme.textTheme.titleMedium!
                .copyWith(color: theme.colorScheme.onSurface),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 70,
            child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(width: 16),
                scrollDirection: Axis.horizontal,
                itemCount: favoriteContacts.length,
                itemBuilder: (ctx, index) {
                  final contact = favoriteContacts[index];
                  return CircleAvatar(
                    radius: 30,
                    backgroundImage: contact.avatar != null
                        ? NetworkImage(contact.avatar!)
                        : const AssetImage('assets/images/default_avatar.jpg')
                            as ImageProvider,
                  );
                }),
          ),
        ],
      ),
    );
  }
}
