import 'package:easy_localization/easy_localization.dart';
import 'package:water/domain/model/home/cart_item.dart';
import 'package:water/domain/model/home/order/order.dart';
import 'package:water/domain/model/home/shop/product.dart';
import 'package:water/domain/model/home/subscription/subscription.dart';

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

extension OrderProductHelper on OrderProduct {
  String get formattedVolume {
    if (volume < 1.0) {
      return '${(volume * 1000).toInt()}${'text.milliliter'.tr()}';
    } else {
      return '$volume${'text.liter'.tr()}';
    }
  }
}

extension SubscriptionHelper on SubscriptionProduct {
  String get formattedVolume {
    if (volume < 1.0) {
      return '${(volume * 1000).toInt()}${'text.milliliter'.tr()}';
    } else {
      return '$volume${'text.liter'.tr()}';
    }
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
