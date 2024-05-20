import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/providers/language_provider.dart';
import 'package:flutter_contacts/providers/go_router_provider.dart';
import 'package:flutter_contacts/providers/theme_provider.dart';
import 'package:flutter_contacts/services/contacts_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_contacts/themes.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Locale> loadSavedLocale() async {
  final preference = await SharedPreferences.getInstance();
  final languageCode = preference.getString('languageCode') ?? 'en';
  final countryCode = preference.getString('countryCode') ?? 'US';
  return Locale(languageCode, countryCode);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  ContactsService().init();

  final savedLocale = await loadSavedLocale();

  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('vi', 'VN'),
          Locale('km', 'KH')
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        startLocale: savedLocale,
        child: const MainApp(),
      ),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final isLightMode = ref.watch(themeNotifierProvider);
    final locale = ref.watch(languageNotifierProvider);

    final routerConfig = ref.watch(goRouterProvider);

    return MaterialApp.router(
      theme: kLightTheme,
      darkTheme: kDarkTheme,
      themeMode: isLightMode ? ThemeMode.light : ThemeMode.dark,
      localizationsDelegates: [
        ...context.localizationDelegates,
        FormBuilderLocalizations.delegate
      ],
      supportedLocales: context.supportedLocales,
      locale: locale,
      routerConfig: routerConfig,
    );
  }
}
