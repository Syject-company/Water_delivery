import 'dart:convert';
import 'dart:io';

import 'package:water/domain/model/payment_response.dart';
import 'package:water/util/http.dart';

class AccountService {
  static const String _endpoint = 'https://gulfaweb.azurewebsites.net/Account';

  Future<PaymentResponse> topUpWallet(String token, double amount) async {
    final response = await Http.post(
      '$_endpoint/TopUpWallet/$amount',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    if (response.statusCode != HttpStatus.ok) {
      throw HttpException(response.body);
    }

    return PaymentResponse.fromJson(jsonDecode(response.body));
  }
}
