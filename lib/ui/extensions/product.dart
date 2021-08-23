import 'package:easy_localization/easy_localization.dart';
import 'package:water/domain/model/order/order.dart';
import 'package:water/domain/model/shopping/product.dart';
import 'package:water/domain/model/subscription/subscription.dart';

extension ProductUtil on Product {
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

extension OrderProductUtil on OrderProduct {
  String get formattedVolume {
    if (volume < 1.0) {
      return '${(volume * 1000).toInt()}${'text.milliliter'.tr()}';
    } else {
      return '$volume${'text.liter'.tr()}';
    }
  }
}

extension SubscriptionProductUtil on SubscriptionProduct {
  String get formattedVolume {
    if (volume < 1.0) {
      return '${(volume * 1000).toInt()}${'text.milliliter'.tr()}';
    } else {
      return '$volume${'text.liter'.tr()}';
    }
  }
}
