import 'package:flutter/material.dart';
import 'package:flutter_contacts/providers/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_contacts/screens/contacts/contacts_screen.dart';
import 'package:flutter_contacts/themes.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final isLightMode = ref.watch(themProvider);
    return MaterialApp(
      theme: kLightTheme,
      darkTheme: kDarkTheme,
      themeMode: isLightMode ? ThemeMode.light : ThemeMode.dark,
      home: const ContactsScreen(),
    );
  }
}
