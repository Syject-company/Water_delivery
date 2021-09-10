part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class PayForOrder extends PaymentEvent {
  const PayForOrder({
    required this.time,
    required this.items,
    required this.address,
  });

  final DeliveryTime time;
  final List<CartItem> items;
  final DeliveryAddress address;

  @override
  List<Object> get props => [
        time,
        items,
        address,
      ];
}

class PayForSubscription extends PaymentEvent {
  const PayForSubscription({
    required this.time,
    required this.items,
    required this.address,
    required this.months,
  });

  final DeliveryTime time;
  final List<CartItem> items;
  final DeliveryAddress address;
  final int months;

  @override
  List<Object> get props => [
        time,
        items,
        address,
        months,
      ];
}

class FinishPayment extends PaymentEvent {
  const FinishPayment();
}
