import 'package:shared_preferences/shared_preferences.dart';
import 'package:water/domain/model/notification.dart' as water;

class Notifications {
  static const String _readNotifications = 'read_notifications';

  static late SharedPreferences _prefs;

  static Future<void> ensureInitialized() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> markAsRead(List<water.Notification> notifications) async {
    final notificationIds = notifications.map((notification) {
      return notification.id;
    }).toList();

    await _prefs.setStringList(_readNotifications, notificationIds);
  }

  static List<String> loadRead() {
    return _prefs.getStringList(_readNotifications) ?? [];
  }
}
