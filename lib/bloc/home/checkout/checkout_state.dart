part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object> get props => [];
}

class DeliveryAddressInput extends CheckoutState {
  const DeliveryAddressInput();
}

class DeliveryTimeInput extends CheckoutState {
  const DeliveryTimeInput({
    required this.address,
    required this.push,
  });

  final DeliveryAddress address;
  final bool push;

  @override
  List<Object> get props => [address];
}

class DeliveryDetailsCollected extends CheckoutState {
  const DeliveryDetailsCollected({
    required this.address,
    required this.time,
    required this.push,
  });

  final DeliveryAddress address;
  final DeliveryTime time;
  final bool push;

  @override
  List<Object> get props => [address, time];
}
