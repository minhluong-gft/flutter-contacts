import 'package:flutter/material.dart';
import 'package:flutter_contacts/widgets/logout_button.dart';
import 'package:flutter_contacts/widgets/switch_langue.dart';
import 'package:flutter_contacts/widgets/toggle_switch_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: const [
                  ToggleSwitchTheme(),
                  Padding(padding: EdgeInsets.all(16), child: SwitchLanguage())
                ],
              ),
            ),
            const LogoutButton(),
          ],
        ),
      ),
    );
  }
}
