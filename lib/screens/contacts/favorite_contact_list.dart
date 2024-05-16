import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_contacts/models/contact.dart';
import 'package:go_router/go_router.dart';

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
            "favorites",
            style: theme.textTheme.titleMedium!
                .copyWith(color: theme.colorScheme.onSurface),
          ).tr(),
          const SizedBox(height: 8),
          SizedBox(
            height: 70,
            child: ListView.separated(
                separatorBuilder: (BuildContext ctx, int index) =>
                    const SizedBox(width: 16),
                scrollDirection: Axis.horizontal,
                itemCount: favoriteContacts.length,
                itemBuilder: (ctx, index) {
                  final contact = favoriteContacts[index];
                  return InkWell(
                    onTap: () {
                      context.pushNamed('contactDetails',
                          pathParameters: {'contactId': contact.id});
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: contact.avatar != null
                          ? NetworkImage(contact.avatar!)
                          : const AssetImage('assets/images/default_avatar.jpg')
                              as ImageProvider,
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
