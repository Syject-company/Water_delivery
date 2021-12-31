import 'dart:convert';
import 'dart:io';

import 'package:water/domain/model/notification.dart' as water;
import 'package:water/utils/http.dart';

class NotificationService {
  static const String _endpoint =
      'https://gulfaweb.azurewebsites.net/Notifications';

  Future<List<water.Notification>> getAll(
    String token, [
    String language = 'en',
  ]) async {
    final response = await Http.get(
      _endpoint,
      headers: {
        HttpHeaders.cacheControlHeader: 'no-cache, no-store, must-revalidate',
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.acceptLanguageHeader: language,
      },
    );

    if (response.statusCode != HttpStatus.ok) {
      throw HttpException(response.body);
    }

    if (response.body.isNotEmpty) {
      final Iterable iterable = jsonDecode(response.body);
      return List<water.Notification>.from(iterable.map((json) {
        return water.Notification.fromJson(json);
      }));
    }

    return [];
  }
}
