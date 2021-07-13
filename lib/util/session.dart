import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static const String _tokenKey = 'token';
  static const String _userIdKey = 'user_id';

  static late SharedPreferences _prefs;

  static Future<void> ensureInitialized() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String? get token => _prefs.getString(_tokenKey);

  static int? get userId => _prefs.getInt(_userIdKey);

  static bool get isActive => token != null;

  static Future<void> open({
    required String token,
    required int userId,
  }) async {
    await _prefs.setString(_tokenKey, token);
    await _prefs.setInt(_userIdKey, userId);
  }

  static void close() async {
    await _prefs.remove(_tokenKey);
    await _prefs.remove(_userIdKey);
  }
}
