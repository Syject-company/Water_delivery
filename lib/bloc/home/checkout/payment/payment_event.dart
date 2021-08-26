part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class PayForOrder extends PaymentEvent {
  const PayForOrder();
}

class PayForSubscription extends PaymentEvent {
  const PayForSubscription({required this.months});

  final int months;

  @override
  List<Object> get props => [months];
}
