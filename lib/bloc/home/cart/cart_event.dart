part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddToCart extends CartEvent {
  const AddToCart({
    required this.product,
    required this.amount,
  });

  final Product product;
  final int amount;

  @override
  List<Object> get props => [product, amount];
}

class RemoveFromCart extends CartEvent {
  const RemoveFromCart({
    required this.product,
  });

  final Product product;

  @override
  List<Object> get props => [product];
}

class ClearCart extends CartEvent {
  const ClearCart();
}
