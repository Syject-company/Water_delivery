import 'dart:convert';
import 'dart:io';

import 'package:water/domain/model/delivery/date.dart';
import 'package:water/domain/model/delivery/period.dart';
import 'package:water/util/http.dart';

class PeriodService {
  static const String _endpoint = 'https://gulfaweb.azurewebsites.net/Periods';

  Future<List<DeliveryDate>> getAll(String city) async {
    final response = await Http.get(
      _endpoint,
      queryParameters: {
        'cityName': city,
      },
    );

    if (response.statusCode != HttpStatus.ok) {
      throw HttpException(response.body);
    }

    if (response.body.isNotEmpty) {
      final Iterable iterable = jsonDecode(response.body);
      return List<DeliveryDate>.from(iterable.map((json) {
        return DeliveryDate.fromJson(json);
      }));
    }

    return [];
  }
}
