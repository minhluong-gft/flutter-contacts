import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogoutButton extends ConsumerWidget {
  const LogoutButton({super.key});

  void _handleLogout(BuildContext context, WidgetRef ref) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              'logout',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
            ).tr(),
            content: Text(
              'message_confirm_logout',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
            ).tr(),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("cancel").tr()),
              ElevatedButton(
                  onPressed: () {
                    ref.read(authProvider.notifier).logout();
                  },
                  child: const Text('logout').tr())
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context, ref) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.error,
          side: BorderSide(color: Theme.of(context).colorScheme.error),
        ),
        onPressed: () => _handleLogout(context, ref),
        child: const Text('logout').tr());
  }
}
