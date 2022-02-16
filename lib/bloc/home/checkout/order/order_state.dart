part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class DeliveryAddressInput extends OrderState {
  const DeliveryAddressInput();
}

class DeliveryTimeInput extends OrderState {
  const DeliveryTimeInput({
    required this.address,
    required this.push,
  });

  final DeliveryAddress address;
  final bool push;

  @override
  List<Object> get props => [address];
}

class OrderDetailsCollected extends OrderState {
  const OrderDetailsCollected({
    required this.address,
    required this.time,
    required this.push,
  });

  final DeliveryAddress address;
  final DeliveryTime time;
  final bool push;

  @override
  List<Object> get props => [
        address,
        time,
      ];
}
