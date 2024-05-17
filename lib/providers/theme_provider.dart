import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(true) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final preference = await SharedPreferences.getInstance();
    final isLightMode = preference.getBool('isLightTheme') ?? true;
    state = isLightMode;
  }

  Future<void> toggleTheme() async {
    state = !state;
    final preference = await SharedPreferences.getInstance();
    preference.setBool('isLightTheme', state);
  }
}

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  return ThemeNotifier();
});
