import 'dart:convert';
import 'dart:io';

import 'package:water/domain/model/payment_response.dart';
import 'package:water/domain/model/order/order.dart';
import 'package:water/domain/model/order/order_form.dart';
import 'package:water/util/http.dart';

class OrderService {
  static const String _endpoint = 'https://gulfaweb.azurewebsites.net/Orders';

  Future<List<Order>> getAll(String token) async {
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
      return List<Order>.from(iterable.map((json) {
        return Order.fromJson(json);
      }));
    }

    return [];
  }

  Future<void> create(String token, OrderForm form) async {
    final response = await Http.post(
      _endpoint,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: form,
    );

    if (response.statusCode != HttpStatus.ok) {
      throw HttpException(response.body);
    }
  }
}
