import 'dart:convert';
import 'dart:io';

import 'package:water/domain/model/profile/change_password_form.dart';
import 'package:water/domain/model/wallet/wallet_payment_response.dart';
import 'package:water/utils/http.dart';

class AccountService {
  static const String _endpoint = 'https://gulfaweb.azurewebsites.net/Account';

  Future<void> changePassword(
    String token,
    ChangePasswordForm form,
  ) async {
    final response = await Http.post(
      '$_endpoint/ChangePassword',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: form,
    );

    if (response.statusCode != HttpStatus.ok) {
      throw HttpException(response.body);
    }
  }

  Future<WalletPaymentResponse> topUpWallet(
    String token,
    double amount,
  ) async {
    final response = await Http.post(
      '$_endpoint/TopUpWallet/$amount',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    if (response.statusCode != HttpStatus.ok) {
      throw HttpException(response.body);
    }

    return WalletPaymentResponse.fromJson(jsonDecode(response.body));
  }
}
