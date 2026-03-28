import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/providers/language_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwitchLanguage extends ConsumerWidget {
  const SwitchLanguage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    Locale currentLocale = Localizations.localeOf(context);

    return Row(
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
            ref.read(languageNotifierProvider.notifier).setLanguage(value!);
            context.setLocale(value);
          },
        ),
      ],
    );
  }
}
