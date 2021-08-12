part of 'delivery_bloc.dart';

abstract class DeliveryEvent extends Equatable {
  const DeliveryEvent();
}

class SubmitDeliveryAddress extends DeliveryEvent {
  const SubmitDeliveryAddress({required this.address});

  final DeliveryAddress address;

  @override
  List<Object> get props => [address];
}

class SubmitDeliveryTime extends DeliveryEvent {
  const SubmitDeliveryTime({required this.time});

  final DeliveryTime time;

  @override
  List<Object> get props => [time];
}
