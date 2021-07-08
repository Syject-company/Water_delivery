import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String i18nBasePath = 'assets/i18n';
const String defaultLocale = 'en';

extension LocalizeString on String {
  String localize(BuildContext context) {
    return FlutterI18n.translate(context, this);
  }
}

enum Language {
  English,
  Arabic,
}

class Localization {
  static const String _savedLocaleKey = 'saved_locale';

  static const Map<Language, Locale> _locales = {
    Language.English: const Locale('en'),
    Language.Arabic: const Locale('ar'),
  };

  static Map<Language, Locale> get locales => _locales;

  static Future<Locale?> changeLanguage(
      BuildContext context, Language language) async {
    if (currentLanguage(context) != language) {
      final locale = _locales[language];
      await FlutterI18n.refresh(context, locale);
      return locale;
    }
  }

  static Language currentLanguage(BuildContext context) {
    return _locales.entries
        .firstWhere((entry) =>
            entry.value.languageCode == currentLocale(context).languageCode)
        .key;
  }

  static Locale currentLocale(BuildContext context) {
    return FlutterI18n.currentLocale(context) ?? const Locale(defaultLocale);
  }

  static Future<Locale> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_savedLocaleKey)
        ? Locale(prefs.getString(_savedLocaleKey)!)
        : const Locale(defaultLocale);
  }

  static Future<void> saveLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_savedLocaleKey, locale.languageCode);
  }
}
