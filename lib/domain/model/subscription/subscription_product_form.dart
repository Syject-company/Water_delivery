import 'package:equatable/equatable.dart';

class SubscriptionProductFormFields {
  static const String id = 'shopItemId';
  static const String amount = 'count';
}

class SubscriptionProductForm extends Equatable {
  const SubscriptionProductForm({
    required this.id,
    required this.amount,
  });

  final String id;
  final int amount;

  Map<String, dynamic> toJson() {
    return {
      SubscriptionProductFormFields.id: id,
      SubscriptionProductFormFields.amount: amount,
    };
  }

  @override
  List<Object> get props => [
        id,
        amount,
      ];
}
