import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'local_storage.dart';

class LocalNotifications {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotifications =
      FlutterLocalNotificationsPlugin();

  static final AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'firebase_notifications',
    'Firebase Notifications',
    description: 'Firebase Notifications Channel',
    importance: Importance.max,
  );

  static Future<void> _firebaseOnBackgroundMessage(
    RemoteMessage message,
  ) async {
    await LocalStorage.ensureInitialized();

    showNotification(
      id: message.hashCode,
      body: message.data[LocalStorage.locale],
    );
  }

  static Future<void> ensureInitialized() async {
    if (Platform.isIOS) {
      await _requestIOSPermission();
    }
    FirebaseMessaging.onBackgroundMessage(_firebaseOnBackgroundMessage);
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
  }

  static Future<void> _requestIOSPermission() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    await _flutterLocalNotifications
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  static Future<void> showNotification({
    required int id,
    required String body,
  }) async {
    await _flutterLocalNotifications.show(
      0,
      null,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: _channel.description,
          styleInformation: DefaultStyleInformation(true, true),
          icon: '@mipmap/ic_launcher',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: IOSNotificationDetails(),
      ),
    );
  }
}
