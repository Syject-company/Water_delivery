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

  Subscription.fromJson(Map<String, dynamic> json)
      : this(
          id: json[SubscriptionFields.id] as String,
          isActive: json[SubscriptionFields.isActive] as bool,
          deliveryDate: json[SubscriptionFields.deliveryDate] as String,
          products:
              json[SubscriptionFields.products] as List<SubscriptionProduct>,
          city: json[SubscriptionFields.city] as String,
          district: json[SubscriptionFields.district] as String,
          street: json[SubscriptionFields.street] as String,
          building: json[SubscriptionFields.building] as String,
          apartment: json[SubscriptionFields.apartment] as String,
          floor: json[SubscriptionFields.floor] as String,
        );

  Map<String, dynamic> toJson() => {
        SubscriptionFields.id: id,
        SubscriptionFields.isActive: isActive,
        SubscriptionFields.deliveryDate: deliveryDate,
        SubscriptionFields.products: products,
        SubscriptionFields.city: city,
        SubscriptionFields.district: district,
        SubscriptionFields.street: street,
        SubscriptionFields.building: building,
        SubscriptionFields.apartment: apartment,
        SubscriptionFields.floor: floor,
      };

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
