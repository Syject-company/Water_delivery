import 'package:equatable/equatable.dart';

import 'subscription_product_form.dart';

export 'subscription_product_form.dart';

class SubscriptionFormFields {
  static const String deliveryDate = 'deliveryDate';
  static const String periodId = 'periodId';
  static const String months = 'subscriptionDurationMonth';
  static const String promo = 'promoCode';
  static const String products = 'shopItems';
  static const String city = 'cityName';
  static const String district = 'districtName';
  static const String street = 'street';
  static const String building = 'building';
  static const String floor = 'floor';
  static const String apartment = 'apartment';
}

class SubscriptionForm extends Equatable {
  const SubscriptionForm({
    required this.deliveryDate,
    required this.periodId,
    required this.months,
    required this.promo,
    required this.products,
    required this.city,
    required this.district,
    required this.street,
    required this.building,
    required this.floor,
    required this.apartment,
  });

  final String deliveryDate;
  final String periodId;
  final int months;
  final String promo;
  final List<SubscriptionProductForm> products;
  final String city;
  final String district;
  final String street;
  final String building;
  final String floor;
  final String apartment;

  Map<String, dynamic> toJson() {
    return {
      SubscriptionFormFields.deliveryDate: deliveryDate,
      SubscriptionFormFields.periodId: periodId,
      SubscriptionFormFields.months: months,
      SubscriptionFormFields.promo: promo,
      SubscriptionFormFields.products: products,
      SubscriptionFormFields.city: city,
      SubscriptionFormFields.district: district,
      SubscriptionFormFields.street: street,
      SubscriptionFormFields.building: building,
      SubscriptionFormFields.floor: floor,
      SubscriptionFormFields.apartment: apartment,
    };
  }

  @override
  List<Object> get props => [
        deliveryDate,
        periodId,
        months,
        promo,
        products,
        city,
        district,
        street,
        building,
        floor,
        apartment,
      ];
}
