import 'dart:convert';
import 'dart:io';

import 'package:water/domain/model/banner.dart' as water;
import 'package:water/util/http.dart';

class BannerService {
  static const String _endpoint = 'https://gulfaweb.azurewebsites.net/Banners';

  Future<List<water.Banner>> getAll() async {
    final response = await Http.get('$_endpoint/');

    if (response.statusCode != HttpStatus.ok) {
      throw HttpException(response.body);
    }

    if (response.body.isNotEmpty) {
      final Iterable banners = jsonDecode(response.body);
      return List<water.Banner>.from(banners.map((banner) {
        return water.Banner.fromJson(banner);
      }));
    }

    return [];
  }
}
