import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water/domain/model/auth/auth_response.dart';
import 'package:water/domain/service/auth_service.dart';
import 'package:water/locator.dart';

class Session {
  static const String _tokenKey = 'token';
  static const String _userIdKey = 'user_id';

  static late SharedPreferences _prefs;

  static final AuthService _authService = locator<AuthService>();

  static Future<void> ensureInitialized() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String? get token => _prefs.getString(_tokenKey);

  static String? get userId => _prefs.getString(_userIdKey);

  static bool get isAuthenticated => token != null;

  static Future<void> open({required AuthResponse auth}) async {
    final fcm = FirebaseMessaging.instance;
    final fcmToken = await fcm.getToken();
    print('Generated FCM token: $fcmToken');
    if (fcmToken != null) {
      await _authService.setFirebaseToken(auth.token, fcmToken);
    }
    print('token: ${auth.token}');

    await _prefs.setString(_tokenKey, auth.token);
    await _prefs.setString(_userIdKey, auth.id);
  }

  static Future<void> invalidate() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.deleteToken();

    await _prefs.remove(_userIdKey);
    await _prefs.remove(_tokenKey);
  }
}
