import 'dart:convert';
import 'dart:io';

import 'package:water/domain/model/promo_code/promo_code.dart';
import 'package:water/utils/http.dart';

class PromoCodeService {
  static const String _endpoint = 'https://gulfaweb.azurewebsites.net/Admin';

  Future<PromoCode> getByCode(String token, String code) async {
    final response = await Http.get(
      '$_endpoint/PromoCode/$code',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    if (response.statusCode != HttpStatus.ok) {
      throw HttpException(response.body);
    }

    return PromoCode.fromJson(jsonDecode(response.body));
  }
}
