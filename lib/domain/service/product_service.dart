import 'dart:convert';
import 'dart:io';

import 'package:water/domain/model/home/shop/product.dart';
import 'package:water/util/http.dart';

class ProductService {
  static const String _endpoint =
      'https://gulfaweb.azurewebsites.net/ShopItems';

  Future<List<Product>> getAllByCategoryId(
    String categoryId,
    String locale,
  ) async {
    final response = await Http.get('$_endpoint/', headers: {
      HttpHeaders.acceptLanguageHeader: locale,
    });

    if (response.statusCode != HttpStatus.ok) {
      throw HttpException(response.body);
    }

    // print(response.body.isNotEmpty ? jsonDecode(response.body) : {});

    if (response.body.isNotEmpty) {
      final Iterable products = jsonDecode(response.body);
      return List<Product>.from(
        products.map((product) => Product.fromJson(product)),
      ).where((product) => product.categoryId == categoryId).toList();
    }

    return [];
  }
}
