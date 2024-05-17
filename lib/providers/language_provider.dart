import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageNotifier extends StateNotifier<Locale> {
  LanguageNotifier() : super(const Locale('en', 'US')) {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final preference = await SharedPreferences.getInstance();
    final languageCode = preference.getString('languageCode') ?? 'en';
    final countryCode = preference.getString('countryCode') ?? 'US';
    state = Locale(languageCode, countryCode);
  }

  Future<void> setLanguage(Locale locale) async {
    state = locale;
    final preference = await SharedPreferences.getInstance();
    await preference.setString('languageCode', locale.languageCode);
    await preference.setString('countryCode', locale.countryCode ?? '');
  }
}

final languageNotifierProvider =
    StateNotifierProvider<LanguageNotifier, Locale>((ref) {
  return LanguageNotifier();
});
