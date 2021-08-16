part of 'delivery_bloc.dart';

abstract class DeliveryState extends Equatable {
  const DeliveryState();

  @override
  List<Object> get props => [];
}

class DeliveryInitial extends DeliveryState {
  const DeliveryInitial();

  @override
  List<Object> get props => [];
}

class DeliveryAddressInput extends DeliveryState {
  const DeliveryAddressInput();
}

class DeliveryTimeInput extends DeliveryState {
  const DeliveryTimeInput({
    required this.address,
  });

  final DeliveryAddress address;

  @override
  List<Object> get props => [address];
}

class DeliveryDetailsCollected extends DeliveryState {
  const DeliveryDetailsCollected({
    required this.address,
    required this.time,
  });

  final DeliveryAddress address;
  final DeliveryTime time;

  @override
  List<Object> get props => [address, time];
}
