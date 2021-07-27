import 'package:equatable/equatable.dart';
import 'package:water/domain/model/home/shop_item.dart';

class CartItem extends Equatable {
  const CartItem({
    required this.item,
    required this.amount,
  });

  final ShopItem item;
  final int amount;

  CartItem copyWith({
    ShopItem? item,
    int? amount,
  }) =>
      CartItem(
        item: item ?? this.item,
        amount: amount ?? this.amount,
      );

  @override
  List<Object> get props => [item, amount];
}
