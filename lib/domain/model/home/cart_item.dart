import 'package:equatable/equatable.dart';
import 'package:water/domain/model/home/shop/product.dart';

class CartItem extends Equatable {
  const CartItem({
    required this.product,
    required this.amount,
  });

  final Product product;
  final int amount;

  CartItem copyWith({
    Product? product,
    int? amount,
  }) =>
      CartItem(
        product: product ?? this.product,
        amount: amount ?? this.amount,
      );



  @override
  List<Object> get props => [product, amount];
}
