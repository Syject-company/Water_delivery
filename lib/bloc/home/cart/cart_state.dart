part of 'cart_bloc.dart';

class CartState extends Equatable {
  const CartState({
    required this.items,
    required this.totalPrice,
    required this.vat,
  });

  final List<CartItem> items;
  final double totalPrice;
  final double vat;

  CartState copyWith({
    List<CartItem>? items,
    double? totalPrice,
    double? vat,
  }) =>
      CartState(
        items: items ?? this.items,
        totalPrice: totalPrice ?? this.totalPrice,
        vat: vat ?? this.vat,
      );

  @override
  List<Object> get props => [
        items,
        totalPrice,
        vat,
      ];
}
