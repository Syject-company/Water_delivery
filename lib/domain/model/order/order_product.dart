import 'package:equatable/equatable.dart';

export 'package:water/ui/extensions/order_product.dart';

class OrderProductFields {
  static const String title = 'title';
  static const String volume = 'volume';
  static const String amount = 'count';
  static const String price = 'price';
}

class OrderProduct extends Equatable {
  const OrderProduct({
    required this.title,
    required this.volume,
    required this.amount,
    required this.price,
  });

  final String title;
  final double volume;
  final int amount;
  final double price;

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      title: json[OrderProductFields.title],
      volume: json[OrderProductFields.volume],
      amount: json[OrderProductFields.amount],
      price: json[OrderProductFields.price],
    );
  }

  @override
  List<Object> get props => [
        title,
        volume,
        amount,
        price,
      ];
}
