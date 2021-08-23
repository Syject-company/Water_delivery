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

  Map<String, dynamic> toJson() => {
        OrderProductFields.title: title,
        OrderProductFields.volume: volume,
        OrderProductFields.amount: amount,
        OrderProductFields.price: price,
      };

  @override
  List<Object> get props => [
        title,
        volume,
        amount,
        price,
      ];
}
