import 'dart:convert';
import 'dart:io';

import 'package:water/domain/model/shopping/product.dart';
import 'package:water/utils/http.dart';

class ProductService {
  static const String _endpoint =
      'https://gulfaweb.azurewebsites.net/ShopItems';

  Future<List<Product>> getAll([String language = 'en']) async {
    final response = await Http.get(
      _endpoint,
      headers: {
        HttpHeaders.acceptLanguageHeader: language,
      },
    );

    if (response.statusCode != HttpStatus.ok) {
      throw HttpException(response.body);
    }

    if (response.body.isNotEmpty) {
      final Iterable iterable = jsonDecode(response.body);
      return List<Product>.from(iterable.map((json) {
        return Product.fromJson(json);
      }));
    }

    return [];
  }

  Future<List<Product>> getAllByCategoryId(
    String categoryId, [
    String language = 'en',
  ]) async {
    final response = await Http.get(
      _endpoint,
      headers: {
        HttpHeaders.acceptLanguageHeader: language,
      },
    );

    if (response.statusCode != HttpStatus.ok) {
      throw HttpException(response.body);
    }

    if (response.body.isNotEmpty) {
      final Iterable iterable = jsonDecode(response.body);
      return List<Product>.from(iterable.map((json) {
        return Product.fromJson(json);
      })).where((product) {
        return product.categoryId == categoryId;
      }).toList(growable: false);
    }

    return [];
  }
}
