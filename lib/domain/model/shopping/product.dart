import 'package:equatable/equatable.dart';

import 'sale.dart';

export 'package:water/ui/extensions/product.dart';

export 'sale.dart';

class ProductFields {
  static const String id = 'id';
  static const String imageUri = 'imageUri';
  static const String price = 'price';
  static const String volume = 'volume';
  static const String categoryId = 'categoryId';
  static const String sale = 'sale';
  static const String title = 'title';
  static const String description = 'description';
}

class Product extends Equatable {
  const Product({
    required this.id,
    required this.imageUri,
    required this.price,
    required this.volume,
    required this.categoryId,
    this.sale,
    required this.title,
    required this.description,
  });

  final String id;
  final String imageUri;
  final double price;
  final double volume;
  final String categoryId;
  final Sale? sale;
  final String title;
  final String description;

  factory Product.fromJson(Map<String, dynamic> json) {
    Sale? sale;
    if (json[ProductFields.sale] != null) {
      sale = Sale.fromJson(json[ProductFields.sale]);
    }

    return Product(
      id: json[ProductFields.id],
      imageUri: json[ProductFields.imageUri],
      price: json[ProductFields.price],
      volume: json[ProductFields.volume],
      categoryId: json[ProductFields.categoryId],
      sale: sale,
      title: json[ProductFields.title],
      description: json[ProductFields.description],
    );
  }

  @override
  List<Object?> get props => [
        id,
        imageUri,
        price,
        volume,
        categoryId,
        sale,
        title,
        description,
      ];
}
