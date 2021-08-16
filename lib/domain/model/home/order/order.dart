import 'package:equatable/equatable.dart';

import 'order_product.dart';

export 'order_product.dart';

class OrderFields {
  static const String id = 'id';
  static const String status = 'status';
  static const String deliveryDate = 'deliveryDay';
  static const String createdDate = 'createDate';
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

  final String id;
  final String status;
  final String deliveryDate;
  final String createdDate;
  final List<OrderProduct> products;
  final String customerName;
  final bool isSubscribed;
  final String city;
  final String district;
  final String street;
  final String building;
  final String apartment;
  final String floor;

  Order.fromJson(Map<String, dynamic> json)
      : this(
          id: json[OrderFields.id] as String,
          status: json[OrderFields.status] as String,
          deliveryDate: json[OrderFields.deliveryDate] as String,
          createdDate: json[OrderFields.createdDate] as String,
          products: json[OrderFields.products] as List<OrderProduct>,
          customerName: json[OrderFields.customerName] as String,
          isSubscribed: json[OrderFields.isSubscribed] as bool,
          city: json[OrderFields.city] as String,
          district: json[OrderFields.district] as String,
          street: json[OrderFields.street] as String,
          building: json[OrderFields.building] as String,
          apartment: json[OrderFields.apartment] as String,
          floor: json[OrderFields.floor] as String,
        );

  Map<String, dynamic> toJson() => {
        OrderFields.id: id,
        OrderFields.status: status,
        OrderFields.deliveryDate: deliveryDate,
        OrderFields.createdDate: createdDate,
        OrderFields.products: products,
        OrderFields.customerName: customerName,
        OrderFields.isSubscribed: isSubscribed,
        OrderFields.city: city,
        OrderFields.district: district,
        OrderFields.street: street,
        OrderFields.building: building,
        OrderFields.apartment: apartment,
        OrderFields.floor: floor,
      };

  @override
  List<Object> get props => [
        id,
        status,
        deliveryDate,
        createdDate,
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
