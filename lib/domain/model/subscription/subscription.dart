import 'package:equatable/equatable.dart';

import 'subscription_product.dart';

export 'subscription_product.dart';

class SubscriptionFields {
  static const String id = 'id';
  static const String isActive = 'isActive';
  static const String deliveryDate = 'deliveryDay';
  static const String products = 'subscriptionShopItems';
  static const String city = 'cityName';
  static const String district = 'districtName';
  static const String street = 'street';
  static const String building = 'building';
  static const String apartment = 'apartment';
  static const String floor = 'floor';
}

class Subscription extends Equatable {
  const Subscription({
    required this.id,
    required this.isActive,
    required this.deliveryDate,
    required this.products,
    required this.city,
    required this.district,
    required this.street,
    required this.building,
    required this.apartment,
    required this.floor,
  });

  final String id;
  final bool isActive;
  final String deliveryDate;
  final List<SubscriptionProduct> products;
  final String city;
  final String district;
  final String street;
  final String building;
  final String apartment;
  final String floor;

  factory Subscription.fromJson(Map<String, dynamic> json) {
    final Iterable iterable = json[SubscriptionFields.products];
    final products = List<SubscriptionProduct>.from(iterable.map((json) {
      return SubscriptionProduct.fromJson(json);
    }));

    return Subscription(
      id: json[SubscriptionFields.id],
      isActive: json[SubscriptionFields.isActive],
      deliveryDate: json[SubscriptionFields.deliveryDate],
      products: products,
      city: json[SubscriptionFields.city],
      district: json[SubscriptionFields.district],
      street: json[SubscriptionFields.street],
      building: json[SubscriptionFields.building],
      apartment: json[SubscriptionFields.apartment],
      floor: json[SubscriptionFields.floor],
    );
  }

  @override
  List<Object> get props => [
        id,
        isActive,
        deliveryDate,
        products,
        city,
        district,
        street,
        building,
        apartment,
        floor,
      ];
}
