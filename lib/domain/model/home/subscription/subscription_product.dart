import 'package:equatable/equatable.dart';

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

  Map<String, dynamic> toJson() => {
        SubscriptionProductFields.title: title,
        SubscriptionProductFields.volume: volume,
        SubscriptionProductFields.amount: amount,
        SubscriptionProductFields.price: price,
      };

  @override
  List<Object> get props => [
        title,
        volume,
        amount,
        price,
      ];
}
