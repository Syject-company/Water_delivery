part of 'cart_bloc.dart';

class CartState extends Equatable {
  const CartState({
    required this.cartItems,
    required this.totalPrice,
  });

  final List<CartItem> cartItems;
  final double totalPrice;

  CartState copyWith({
    List<CartItem>? cartItems,
    double? totalPrice,
  }) =>
      CartState(
        cartItems: cartItems ?? this.cartItems,
        totalPrice: totalPrice ?? this.totalPrice,
      );

  @override
  List<Object> get props => [cartItems, totalPrice];
}
