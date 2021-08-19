import 'package:equatable/equatable.dart';

import 'sale.dart';

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

  Product.fromJson(Map<String, dynamic> json)
      : this(
          id: json[ProductFields.id] as String,
          imageUri: json[ProductFields.imageUri] as String,
          price: json[ProductFields.price] as double,
          volume: json[ProductFields.volume] as double,
          categoryId: json[ProductFields.categoryId] as String,
          sale: json[ProductFields.sale] as Sale?,
          title: json[ProductFields.title] as String,
          description: json[ProductFields.description] as String,
        );

  Map<String, dynamic> toJson() => {
        ProductFields.id: id,
        ProductFields.imageUri: imageUri,
        ProductFields.price: price,
        ProductFields.volume: volume,
        ProductFields.categoryId: categoryId,
        ProductFields.sale: sale,
        ProductFields.title: title,
        ProductFields.description: description,
      };

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
