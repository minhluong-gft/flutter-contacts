import 'package:flutter_contacts/models/contact.dart';
import 'package:flutter_contacts/providers/contacts_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteContactsProvider = StateProvider<List<Contact>>((ref) {
  final initialData = ref.watch(filterFavoriteContactsProvider);
  return initialData;
});
