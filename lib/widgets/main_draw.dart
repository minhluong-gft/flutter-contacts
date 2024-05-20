import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/providers/auth_provider.dart';
import 'package:flutter_contacts/providers/language_provider.dart';
import 'package:flutter_contacts/providers/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({super.key});

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
  Widget build(BuildContext context, WidgetRef ref) {
    final isLightTheme = ref.watch(themeNotifierProvider);
    Locale currentLocale = Localizations.localeOf(context);

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
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
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ).tr(),
                        DropdownButton(
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                          items: const [
                            DropdownMenuItem(
                              value: Locale('en', 'US'),
                              child: Text('English'),
                            ),
                            DropdownMenuItem(
                              value: Locale('vi', 'VN'),
                              child: Text('Tiếng Việt'),
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
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,
                  side: BorderSide(color: Theme.of(context).colorScheme.error),
                ),
                onPressed: () => _handleLogout(context, ref),
                child: const Text('logout').tr())
          ],
        ),
      ),
    );
  }
}
