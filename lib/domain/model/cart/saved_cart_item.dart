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
  }) {
    return SavedCartItem(
      id: id ?? this.id,
      amount: amount ?? this.amount,
    );
  }

  factory SavedCartItem.fromJson(Map<String, dynamic> json) {
    return SavedCartItem(
      id: json[SavedCartItemFields.id],
      amount: json[SavedCartItemFields.amount],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      SavedCartItemFields.id: id,
      SavedCartItemFields.amount: amount,
    };
  }

  @override
  List<Object> get props => [
        id,
        amount,
      ];
}
