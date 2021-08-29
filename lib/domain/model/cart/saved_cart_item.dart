import 'package:equatable/equatable.dart';

export 'package:water/ui/extensions/cart_item.dart';
export 'package:water/ui/extensions/product.dart';

class SavedCartItemFields {
  static const String id = 'id';
  static const String amount = 'amount';
}

class SavedCartItem extends Equatable {
  const SavedCartItem({
    required this.id,
    required this.amount,
  });

  final String id;
  final int amount;

  SavedCartItem copyWith({
    String? id,
    int? amount,
  }) =>
      SavedCartItem(
        id: id ?? this.id,
        amount: amount ?? this.amount,
      );

  SavedCartItem.fromJson(Map<String, dynamic> json)
      : this(
          id: json[SavedCartItemFields.id] as String,
          amount: json[SavedCartItemFields.amount] as int,
        );

  Map<String, dynamic> toJson() => {
        SavedCartItemFields.id: id,
        SavedCartItemFields.amount: amount,
      };

  @override
  List<Object> get props => [id, amount];
}
