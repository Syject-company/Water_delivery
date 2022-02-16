import 'package:shared_preferences/shared_preferences.dart';

class NotificationsUtil {
  static const String _readNotificationsKey = 'read_notifications';

  static late SharedPreferences _prefs;

  static Future<void> ensureInitialized() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static List<String>? get loadReadNotifications =>
      _prefs.getStringList(_readNotificationsKey);

  static Future<void> markAsRead(List<String> notificationIds) {
    return _prefs.setStringList(_readNotificationsKey, notificationIds);
  }
}
