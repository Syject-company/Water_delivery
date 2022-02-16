import 'dart:convert';
import 'dart:io';

import 'package:water/domain/model/shopping/category.dart';
import 'package:water/utils/http.dart';

class CategoryService {
  static const String _endpoint =
      'https://gulfaweb.azurewebsites.net/Categories';

  Future<List<Category>> getAll([String language = 'en']) async {
    final response = await Http.get(
      _endpoint,
      headers: {
        HttpHeaders.acceptLanguageHeader: language,
      },
    );

    if (response.statusCode != HttpStatus.ok)
      throw HttpException(response.body);

    if (response.body.isNotEmpty) {
      final Iterable iterable = jsonDecode(response.body);
      return List<Category>.from(iterable.map((json) {
        return Category.fromJson(json);
      }));
    }

    return [];
  }
}
