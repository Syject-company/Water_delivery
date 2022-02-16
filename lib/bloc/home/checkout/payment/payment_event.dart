part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object?> get props => [];
}

class PayForOrder extends PaymentEvent {
  const PayForOrder({
    required this.time,
    required this.items,
    required this.address,
    this.promoCode,
  });

  final DeliveryTime time;
  final List<CartItem> items;
  final DeliveryAddress address;
  final String? promoCode;

  @override
  List<Object?> get props => [
        time,
        items,
        address,
        promoCode,
      ];
}

class PayForSubscription extends PaymentEvent {
  const PayForSubscription({
    required this.time,
    required this.items,
    required this.address,
    required this.months,
    this.promoCode,
  });

  final DeliveryTime time;
  final List<CartItem> items;
  final DeliveryAddress address;
  final int months;
  final String? promoCode;

  @override
  List<Object?> get props => [
        time,
        items,
        address,
        months,
        promoCode,
      ];
}

class FinishPayment extends PaymentEvent {
  const FinishPayment();
}
