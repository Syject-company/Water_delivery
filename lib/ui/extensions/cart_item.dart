import 'package:water/domain/model/cart_item.dart';

extension CartItemUtil on CartItem {
  double get totalPrice {
    return product.price * amount;
  }

  double get totalDiscountPrice {
    return totalPrice * (1.0 - product.discount);
  }
}
