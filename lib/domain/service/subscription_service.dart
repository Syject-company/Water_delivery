import 'dart:convert';
import 'dart:io';

import 'package:water/domain/model/subscription/subscription.dart';
import 'package:water/util/http.dart';

class SubscriptionService {
  static const String _endpoint =
      'https://gulfaweb.azurewebsites.net/Subscriptions';

  Future<List<Subscription>> getAll(String token) async {
    final response = await Http.get(
      _endpoint,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    if (response.statusCode != HttpStatus.ok) {
      throw HttpException(response.body);
    }

    if (response.body.isNotEmpty) {
      final Iterable iterable = jsonDecode(response.body);
      return List<Subscription>.from(iterable.map((json) {
        return Subscription.fromJson(json);
      }));
    }

    return [];
  }
}
