import 'package:flutter/material.dart';
import 'package:flutter_contacts/providers/favorite_contacts_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteContactList extends ConsumerWidget {
  const FavoriteContactList({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final favoriteContacts = ref.watch(favoriteContactsProvider);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        child: favoriteContacts.isEmpty
            ? const Text(
                "No Favorite Contacts",
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "My Favorite Contacts",
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(height: 1),
                        scrollDirection: Axis.horizontal,
                        itemCount: favoriteContacts.length,
                        itemBuilder: (ctx, index) {
                          final contact = favoriteContacts[index];
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                            child: CircleAvatar(
                                backgroundImage: NetworkImage(contact.avatar!)),
                          );
                        }),
                  ),
                ],
              ),
      ),
    );
  }
}
