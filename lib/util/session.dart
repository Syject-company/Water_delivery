import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water/domain/model/auth/auth_response.dart';
import 'package:water/ui/screens/router.dart';

class Session {
  static const String _tokenKey = 'token';
  static const String _userIdKey = 'user_id';

  static late SharedPreferences _prefs;

  static Future<void> ensureInitialized() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String? get token => _prefs.getString(_tokenKey);

  static String? get userId => _prefs.getString(_userIdKey);

  static bool get isActive => token != null;

  static Future<void> open({required AuthResponse auth}) async {
    await _prefs.setString(_tokenKey, auth.token);
    await _prefs.setString(_userIdKey, auth.id);
  }

  static void invalidate(BuildContext context) async {
    Navigator.of(context, rootNavigator: true)
        .pushReplacementNamed(AppRoutes.auth);
    _prefs.remove(_tokenKey);
    _prefs.remove(_userIdKey);
  }
}
