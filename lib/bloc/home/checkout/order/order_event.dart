part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class BackPressed extends OrderEvent {
  const BackPressed();
}

class SubmitDeliveryAddress extends OrderEvent {
  const SubmitDeliveryAddress({required this.address});

  final DeliveryAddress address;

  @override
  List<Object> get props => [address];
}

class SubmitDeliveryTime extends OrderEvent {
  const SubmitDeliveryTime({required this.time});

  final DeliveryTime time;

  @override
  List<Object> get props => [time];
}
