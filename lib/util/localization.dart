import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Localization {
  static const String _appLocaleKey = 'app_locale';

  static const Locale defaultLocale = const Locale('en');
  static const String i18nBasePath = 'assets/i18n';
  static const bool useCountryCode = false;

  static const List<Locale> locales = const [
    const Locale('en'),
    const Locale('ar'),
  ];

  static Locale currentLocale(BuildContext context) {
    return context.locale;
  }

  static void changeLocale(BuildContext context, Locale locale) {
    context.setLocale(locale);
  }

  static Future<Locale> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_appLocaleKey)
        ? Locale(prefs.getString(_appLocaleKey)!)
        : defaultLocale;
  }

  static Future<void> saveLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_appLocaleKey, locale.languageCode);
  }
}
