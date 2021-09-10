import 'package:equatable/equatable.dart';

class WalletPaymentResponseFields {
  static const String walletId = 'walletId';
  static const String paymentUrl = 'paymentPageUri';
}

class WalletPaymentResponse extends Equatable {
  const WalletPaymentResponse({
    required this.walletId,
    required this.paymentUrl,
  });

  final String walletId;
  final String paymentUrl;

  factory WalletPaymentResponse.fromJson(Map<String, dynamic> json) {
    return WalletPaymentResponse(
      walletId: json[WalletPaymentResponseFields.walletId],
      paymentUrl: json[WalletPaymentResponseFields.paymentUrl],
    );
  }

  @override
  List<Object> get props => [
        walletId,
        paymentUrl,
      ];
}
