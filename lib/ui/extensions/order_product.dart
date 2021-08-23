import 'package:easy_localization/easy_localization.dart';
import 'package:water/domain/model/order/order.dart';

extension OrderProductUtil on OrderProduct {
  String get formattedVolume {
    if (volume < 1.0) {
      return '${(volume * 1000).toInt()}${'text.milliliter'.tr()}';
    } else {
      return '$volume${'text.liter'.tr()}';
    }
  }
}
