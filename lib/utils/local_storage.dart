import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String _localeKey = 'app_locale';
  static const String _firstLaunchKey = 'first_launch';

  static late SharedPreferences _prefs;

  static Future<void> ensureInitialized() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String? get locale => _prefs.getString(_localeKey);

  static Future<void> setLocale(String locale) =>
      _prefs.setString(_localeKey, locale);

  static bool? get firstLaunch => _prefs.getBool(_firstLaunchKey);

  static Future<void> setFirstLaunch(bool firstLaunch) =>
      _prefs.setBool(_firstLaunchKey, firstLaunch);
}
