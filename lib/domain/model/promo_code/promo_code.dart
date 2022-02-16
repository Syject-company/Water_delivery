import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

class PromoCodeFields {
  static const String id = 'id';
  static const String code = 'code';
  static const String discount = 'discount';
  static const String discountAmount = 'toDiscountAmount';
  static const String expireDate = 'expireDate';
  static const String amount = 'personalAmountUse';
}

class PromoCode extends Equatable {
  const PromoCode({
    required this.id,
    required this.code,
    required this.discount,
    required this.discountAmount,
    required this.expireDate,
    required this.amount,
  });

  final String id;
  final String code;
  final double discount;
  final double discountAmount;
  final DateTime expireDate;
  final int amount;

  factory PromoCode.fromJson(Map<String, dynamic> json) {
    final discount = json[PromoCodeFields.discount] / 100;
    final expireDate = DateFormat('yyyy-MM-ddTHH:mm:ss')
        .parse(json[PromoCodeFields.expireDate]);

    return PromoCode(
      id: json[PromoCodeFields.id],
      code: json[PromoCodeFields.code],
      discount: discount,
      discountAmount: json[PromoCodeFields.discountAmount],
      expireDate: expireDate,
      amount: json[PromoCodeFields.amount],
    );
  }

  @override
  List<Object> get props => [
        id,
        code,
        discount,
        discountAmount,
        expireDate,
        amount,
      ];
}
