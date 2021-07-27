import 'package:equatable/equatable.dart';

import 'sale.dart';

class ShopItemFields {
  static const String id = 'id';
  static const String imageUri = 'imageUri';
  static const String price = 'price';
  static const String volume = 'volume';
  static const String categoryId = 'categoryId';
  static const String sale = 'sale';
  static const String title = 'title';
  static const String description = 'description';
}

class ShopItem extends Equatable {
  const ShopItem({
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

  ShopItem.fromJson(Map<String, dynamic> json)
      : this(
          id: json[ShopItemFields.id] as String,
          imageUri: json[ShopItemFields.imageUri] as String,
          price: json[ShopItemFields.price] as double,
          volume: json[ShopItemFields.volume] as double,
          categoryId: json[ShopItemFields.categoryId] as String,
          sale: json[ShopItemFields.sale] as Sale?,
          title: json[ShopItemFields.title] as String,
          description: json[ShopItemFields.description] as String,
        );

  Map<String, dynamic> toJson() => {
        ShopItemFields.id: id,
        ShopItemFields.imageUri: imageUri,
        ShopItemFields.price: price,
        ShopItemFields.volume: volume,
        ShopItemFields.categoryId: categoryId,
        ShopItemFields.sale: sale,
        ShopItemFields.title: title,
        ShopItemFields.description: description,
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
