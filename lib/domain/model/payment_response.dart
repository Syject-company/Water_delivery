import 'package:equatable/equatable.dart';

export 'order/order_product.dart';

class PaymentResponseFields {
  static const String orderId = 'orderId';
  static const String paymentUrl = 'paymentPageUri';
}

class PaymentResponse extends Equatable {
  const PaymentResponse({
    required this.orderId,
    required this.paymentUrl,
  });

  final int orderId;
  final String paymentUrl;

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      orderId: json[PaymentResponseFields.orderId],
      paymentUrl: json[PaymentResponseFields.paymentUrl],
    );
  }

  @override
  List<Object> get props => [
        orderId,
        paymentUrl,
      ];
}
