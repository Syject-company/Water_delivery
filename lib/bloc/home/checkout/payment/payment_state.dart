part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {
  const PaymentInitial();
}

class PaymentProcessing extends PaymentState {
  const PaymentProcessing();
}

class SuccessfulPayment extends PaymentState {
  const SuccessfulPayment();
}

class TopUpWallet extends PaymentState {
  const TopUpWallet();
}
