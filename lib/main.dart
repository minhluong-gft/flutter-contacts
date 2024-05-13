import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_contacts/screens/contacts/contacts_screen.dart';
import 'package:flutter_contacts/themes.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: kLightTheme,
      darkTheme: kDarkTheme,
      themeMode: ThemeMode.light,
      home: const ContactsScreen(),
    );
  }
}
