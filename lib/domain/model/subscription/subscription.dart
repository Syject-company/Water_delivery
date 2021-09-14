import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:water/domain/model/delivery/period.dart';

import 'subscription_product.dart';

export 'subscription_product.dart';

class SubscriptionFields {
  static const String id = 'id';
  static const String isActive = 'isActive';
  static const String deliveryDate = 'deliveryDate';
  static const String expireDate = 'subscriptionExpireDate';
  static const String time = 'periods';
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
    required this.expireDate,
    required this.time,
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
  final DateTime deliveryDate;
  final DateTime expireDate;
  final Period time;
  final List<SubscriptionProduct> products;
  final String city;
  final String district;
  final String street;
  final String building;
  final String apartment;
  final String floor;

  factory Subscription.fromJson(Map<String, dynamic> json) {
    final deliveryDate =
        DateFormat('yyyy-MM-dd').parse(json[SubscriptionFields.deliveryDate]);
    final expireDate = DateFormat('yyyy-MM-ddTHH:mm:ss')
        .parse(json[SubscriptionFields.expireDate]);
    final Iterable iterable = json[SubscriptionFields.products];
    final products = List<SubscriptionProduct>.from(iterable.map((json) {
      return SubscriptionProduct.fromJson(json);
    }));

    return Subscription(
      id: json[SubscriptionFields.id],
      isActive: json[SubscriptionFields.isActive],
      deliveryDate: deliveryDate,
      expireDate: expireDate,
      time: Period.fromJson(json[SubscriptionFields.time]),
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
        expireDate,
        time,
        products,
        city,
        district,
        street,
        building,
        apartment,
        floor,
      ];
}
