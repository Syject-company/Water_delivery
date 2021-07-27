part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class ChangeShopItemAmount extends CartEvent {
  const ChangeShopItemAmount({
    required this.id,
    required this.amount,
  });

  final String id;
  final int amount;

  @override
  List<Object> get props => [id, amount];
}

class RemoveFromCart extends CartEvent {
  const RemoveFromCart({
    required this.id,
  });

  final String id;

  @override
  List<Object> get props => [id];
}
