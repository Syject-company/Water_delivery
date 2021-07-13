import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'local_storage.dart';

class Localization {
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

  static Locale loadLocale() {
    return Locale(LocalStorage.locale ?? defaultLocale.languageCode);
  }

  static Future<void> saveLocale(Locale locale) async {
    await LocalStorage.setLocale(locale.languageCode);
  }
}
