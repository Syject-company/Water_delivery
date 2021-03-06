import 'dart:convert';
import 'dart:io';

import 'package:water/domain/model/banner.dart' as water;
import 'package:water/utils/http.dart';

class BannerService {
  static const String _endpoint = 'https://gulfaweb.azurewebsites.net/Banners';

  Future<List<water.Banner>> getAll([String language = 'en']) async {
    final response = await Http.get(
      '$_endpoint/localized',
      headers: {
        HttpHeaders.acceptLanguageHeader: language,
      },
    );

    if (response.statusCode != HttpStatus.ok) {
      throw HttpException(response.body);
    }

    if (response.body.isNotEmpty) {
      final Iterable iterable = jsonDecode(response.body);
      return List<water.Banner>.from(iterable.map((json) {
        return water.Banner.fromJson(json);
      }));
    }

    return [];
  }
}
