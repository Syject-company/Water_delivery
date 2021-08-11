import 'package:easy_localization/easy_localization.dart';
import 'package:water/domain/model/home/cart_item.dart';
import 'package:water/domain/model/home/shop/product.dart';

extension ProductHelper on Product {
  String get formattedVolume {
    if (volume < 1.0) {
      return '${(volume * 1000).toInt()}${'text.milliliter'.tr()}';
    } else {
      return '$volume${'text.liter'.tr()}';
    }
  }

  double get discount {
    return sale?.percent ?? 0.0;
  }

  double get discountPrice {
    return price * (1.0 - discount);
  }
}

extension CartItemHelper on CartItem {
  double get totalPrice {
    return product.price * amount;
  }

  double get totalDiscountPrice {
    return totalPrice * (1.0 - product.discount);
  }
}
