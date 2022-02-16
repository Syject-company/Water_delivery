import 'package:equatable/equatable.dart';

export 'package:water/ui/extensions/subscription_product.dart';

class SubscriptionProductFields {
  static const String title = 'title';
  static const String volume = 'volume';
  static const String amount = 'count';
  static const String price = 'price';
}

class SubscriptionProduct extends Equatable {
  const SubscriptionProduct({
    required this.title,
    required this.volume,
    required this.amount,
    required this.price,
  });

  final String title;
  final double volume;
  final int amount;
  final double price;

  factory SubscriptionProduct.fromJson(Map<String, dynamic> json) {
    return SubscriptionProduct(
      title: json[SubscriptionProductFields.title],
      volume: json[SubscriptionProductFields.volume],
      amount: json[SubscriptionProductFields.amount],
      price: json[SubscriptionProductFields.price],
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
