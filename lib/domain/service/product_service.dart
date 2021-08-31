import 'dart:convert';
import 'dart:io';

import 'package:water/domain/model/shopping/product.dart';
import 'package:water/util/http.dart';

class ProductService {
  static const String _endpoint =
      'https://gulfaweb.azurewebsites.net/ShopItems';

  Future<List<Product>> getAll(String language) async {
    final response = await Http.get(
      '$_endpoint/',
      headers: {
        HttpHeaders.acceptLanguageHeader: language,
      },
    );

    if (response.statusCode != HttpStatus.ok) {
      throw HttpException(response.body);
    }

    if (response.body.isNotEmpty) {
      final Iterable products = jsonDecode(response.body);
      return List<Product>.from(
        products.map((product) {
          return Product.fromJson(product);
        }),
      );
    }

    return [];
  }

  Future<List<Product>> getAllByCategoryId(
    String categoryId,
    String language,
  ) async {
    final response = await Http.get(
      '$_endpoint/',
      headers: {
        HttpHeaders.acceptLanguageHeader: language,
      },
    );

    if (response.statusCode != HttpStatus.ok) {
      throw HttpException(response.body);
    }

    if (response.body.isNotEmpty) {
      final Iterable products = jsonDecode(response.body);
      return List<Product>.from(products.map((product) {
        return Product.fromJson(product);
      })).where((product) {
        return product.categoryId == categoryId;
      }).toList();
    }

    return [];
  }
}
