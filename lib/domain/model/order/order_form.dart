import 'package:equatable/equatable.dart';

import 'order_product_form.dart';

export 'order_product_form.dart';

class OrderFormFields {
  static const String deliveryDate = 'deliveryDate';
  static const String periodId = 'periodId';
  static const String promo = 'promoCode';
  static const String products = 'shopItems';
  static const String city = 'cityName';
  static const String district = 'districtName';
  static const String street = 'street';
  static const String building = 'building';
  static const String floor = 'floor';
  static const String apartment = 'apartment';
}

class OrderForm extends Equatable {
  const OrderForm({
    required this.deliveryDate,
    required this.periodId,
    this.promo,
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
  final String? promo;
  final List<OrderProductForm> products;
  final String city;
  final String district;
  final String street;
  final String building;
  final String floor;
  final String apartment;

  Map<String, dynamic> toJson() {
    return {
      OrderFormFields.deliveryDate: deliveryDate,
      OrderFormFields.periodId: periodId,
      OrderFormFields.promo: promo,
      OrderFormFields.products: products,
      OrderFormFields.city: city,
      OrderFormFields.district: district,
      OrderFormFields.street: street,
      OrderFormFields.building: building,
      OrderFormFields.floor: floor,
      OrderFormFields.apartment: apartment,
    };
  }

  @override
  List<Object?> get props => [
        deliveryDate,
        periodId,
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
