import 'package:flutter_contacts/providers/auth_provider.dart';
import 'package:flutter_contacts/providers/language_provider.dart';
import 'package:flutter_contacts/screens/contacts/contacts_screen.dart';
import 'package:flutter_contacts/screens/contacts_details_screen.dart';
import 'package:flutter_contacts/screens/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final authNotifier = ref.read(authProvider.notifier);
  ref.watch(languageNotifierProvider);

  return GoRouter(
    // debugLogDiagnostics: kDebugMode,
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
          name: 'contacts',
          path: '/contacts',
          builder: (context, state) => const ContactsScreen()),
      GoRoute(
          name: 'contactDetails',
          path: '/contacts/:contactId',
          builder: (context, state) =>
              ContactDetailsScreen(state.pathParameters['contactId']!)),
    ],
    refreshListenable: authNotifier,
    redirect: (context, goRouterState) => authNotifier.redirect(
      goRouterState,
    ),
  );
});
