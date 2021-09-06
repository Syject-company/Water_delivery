import 'package:easy_localization/easy_localization.dart';
import 'package:water/domain/model/shopping/product.dart';

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
