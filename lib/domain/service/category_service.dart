import 'dart:convert';
import 'dart:io';

import 'package:water/domain/model/home/shop/category.dart';
import 'package:water/util/http.dart';

class CategoryService {
  static const String _endpoint =
      'https://gulfaweb.azurewebsites.net/Categories';

  Future<List<Category>> getAll(String locale) async {
    final response = await Http.get('$_endpoint/', headers: {
      HttpHeaders.acceptLanguageHeader: locale,
    });

    if (response.statusCode != HttpStatus.ok)
      throw HttpException(response.body);

    // print(response.body.isNotEmpty ? jsonDecode(response.body) : {});

    if (response.body.isNotEmpty) {
      final Iterable categories = jsonDecode(response.body);
      return List<Category>.from(
        categories.map(
          (category) => Category.fromJson(category),
        ),
      );
    }

    return [];
  }
}
