import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/providers/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ToggleSwitchTheme extends ConsumerWidget {
  const ToggleSwitchTheme({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final isLightTheme = ref.watch(themeNotifierProvider);

    return SwitchListTile(
      title: const Text("lightMode").tr(),
      value: isLightTheme,
      onChanged: (value) {
        ref.read(themeNotifierProvider.notifier).toggleTheme();
      },
      contentPadding: const EdgeInsets.all(16),
    );
  }
}
