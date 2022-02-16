part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {
  const PaymentInitial();
}

class OrderPaymentRequest extends PaymentState {
  const OrderPaymentRequest();
}

class OrderPaymentView extends PaymentState {
  const OrderPaymentView({
    required this.url,
  });

  final String url;

  @override
  List<Object> get props => [url];
}

class SubscriptionPaymentRequest extends PaymentState {
  const SubscriptionPaymentRequest();
}

class SuccessfulPayment extends PaymentState {
  const SuccessfulPayment();
}

class TopUpWallet extends PaymentState {
  const TopUpWallet();
}

class PaymentError extends PaymentState {
  const PaymentError();
}
