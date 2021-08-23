part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

class BackPressed extends CheckoutEvent {
  const BackPressed();
}

class SubmitDeliveryAddress extends CheckoutEvent {
  const SubmitDeliveryAddress({required this.address});

  final DeliveryAddress address;

  @override
  List<Object> get props => [address];
}

class SubmitDeliveryTime extends CheckoutEvent {
  const SubmitDeliveryTime({required this.time});

  final DeliveryTime time;

  @override
  List<Object> get props => [time];
}
