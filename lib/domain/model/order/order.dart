import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:water/domain/model/delivery/period.dart';

import 'order_product.dart';

export 'order_product.dart';

class OrderFields {
  static const String id = 'id';
  static const String status = 'status';
  static const String deliveryDate = 'deliveryDate';
  static const String createdDate = 'createDate';
  static const String time = 'periods';
  static const String products = 'ordersShopItems';
  static const String customerName = 'customerName';
  static const String isSubscribed = 'isSubscribed';
  static const String city = 'cityName';
  static const String district = 'districtName';
  static const String street = 'street';
  static const String building = 'building';
  static const String apartment = 'apartment';
  static const String floor = 'floor';
}

class Order extends Equatable {
  const Order({
    required this.id,
    required this.status,
    required this.deliveryDate,
    required this.createdDate,
    required this.time,
    required this.products,
    required this.customerName,
    required this.isSubscribed,
    required this.city,
    required this.district,
    required this.street,
    required this.building,
    required this.apartment,
    required this.floor,
  });

  final int id;
  final String status;
  final DateTime deliveryDate;
  final DateTime createdDate;
  final Period time;
  final List<OrderProduct> products;
  final String customerName;
  final bool? isSubscribed;
  final String city;
  final String district;
  final String street;
  final String building;
  final String apartment;
  final String floor;

  factory Order.fromJson(Map<String, dynamic> json) {
    final deliveryDate =
        DateFormat('yyyy-MM-dd').parse(json[OrderFields.deliveryDate]);
    final createdDate =
        DateFormat('yyyy-MM-dd').parse(json[OrderFields.createdDate]);
    final Iterable iterable = json[OrderFields.products];
    final products = List<OrderProduct>.from(iterable.map((json) {
      return OrderProduct.fromJson(json);
    }));

    return Order(
      id: json[OrderFields.id],
      status: json[OrderFields.status],
      deliveryDate: deliveryDate,
      createdDate: createdDate,
      time: Period.fromJson(json[OrderFields.time]),
      products: products,
      customerName: json[OrderFields.customerName],
      isSubscribed: json[OrderFields.isSubscribed],
      city: json[OrderFields.city],
      district: json[OrderFields.district],
      street: json[OrderFields.street],
      building: json[OrderFields.building],
      apartment: json[OrderFields.apartment],
      floor: json[OrderFields.floor],
    );
  }

  @override
  List<Object?> get props => [
        id,
        status,
        deliveryDate,
        createdDate,
        time,
        products,
        customerName,
        isSubscribed,
        city,
        district,
        street,
        building,
        apartment,
        floor,
      ];
}
