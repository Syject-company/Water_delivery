import 'dart:convert';
import 'dart:io';

import 'package:water/domain/model/notification.dart' as water;
import 'package:water/util/http.dart';

class NotificationService {
  static const String _endpoint =
      'https://gulfaweb.azurewebsites.net/Notifications';

  Future<List<water.Notification>> getAll(String token) async {
    final response = await Http.get('$_endpoint/', headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });

    if (response.statusCode != HttpStatus.ok) {
      throw HttpException(response.body);
    }

    if (response.body.isNotEmpty) {
      final Iterable notifications = jsonDecode(response.body);
      return List<water.Notification>.from(
        notifications.map((notification) {
          return water.Notification.fromJson(notification);
        }),
      );
    }

    return [];
  }
}
