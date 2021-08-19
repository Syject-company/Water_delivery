part of 'delivery_bloc.dart';

abstract class DeliveryState extends Equatable {
  const DeliveryState();

  @override
  List<Object> get props => [];
}

class DeliveryAddressInput extends DeliveryState {
  const DeliveryAddressInput();
}

class DeliveryTimeInput extends DeliveryState {
  const DeliveryTimeInput({
    required this.address,
    required this.push,
  });

  final DeliveryAddress address;
  final bool push;

  @override
  List<Object> get props => [address];
}

class DeliveryDetailsCollected extends DeliveryState {
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
