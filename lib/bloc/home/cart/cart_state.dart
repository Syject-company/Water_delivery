part of 'cart_bloc.dart';

class CartState extends Equatable {
  const CartState({
    required this.items,
    required this.totalPrice,
  });

  final List<CartItem> items;
  final double totalPrice;

  CartState copyWith({
    List<CartItem>? items,
    double? totalPrice,
  }) =>
      CartState(
        items: items ?? this.items,
        totalPrice: totalPrice ?? this.totalPrice,
      );

  @override
  List<Object> get props => [items, totalPrice];
}
