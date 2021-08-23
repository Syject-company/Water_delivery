import 'package:equatable/equatable.dart';

import 'order_product_form.dart';

class OrderFormFields {
  static const String deliveryDate = 'deliveryDate';
  static const String periodId = 'periodId';
  static const String products = 'shopItems';
  static const String city = 'cityName';
  static const String district = 'districtName';
  static const String address = 'street';
  static const String building = 'building';
  static const String floor = 'floor';
  static const String apartment = 'apartment';
}

class OrderForm extends Equatable {
  const OrderForm({
    required this.deliveryDate,
    required this.periodId,
    required this.products,
    required this.city,
    required this.district,
    required this.address,
    required this.building,
    required this.floor,
    required this.apartment,
  });

  final String deliveryDate;
  final String periodId;
  final List<OrderProductForm> products;
  final String city;
  final String district;
  final String address;
  final String building;
  final String floor;
  final String apartment;

  Map<String, dynamic> toJson() => {
        OrderFormFields.deliveryDate: deliveryDate,
        OrderFormFields.periodId: periodId,
        OrderFormFields.products: products,
        OrderFormFields.city: city,
        OrderFormFields.district: district,
        OrderFormFields.address: address,
        OrderFormFields.building: building,
        OrderFormFields.floor: floor,
        OrderFormFields.apartment: apartment,
      };

  @override
  List<Object> get props => [
        deliveryDate,
        periodId,
        products,
        city,
        district,
        address,
        building,
        floor,
        apartment,
      ];
}
