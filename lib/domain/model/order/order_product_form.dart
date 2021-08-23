import 'package:equatable/equatable.dart';

class OrderProductFields {
  static const String id = 'shopItemId';
  static const String amount = 'count';
}

class OrderProductForm extends Equatable {
  const OrderProductForm({
    required this.id,
    required this.amount,
  });

  final String id;
  final int amount;

  Map<String, dynamic> toJson() => {
        OrderProductFields.id: id,
        OrderProductFields.amount: amount,
      };

  @override
  List<Object?> get props => [id, amount];
}
