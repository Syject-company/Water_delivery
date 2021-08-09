part of 'delivery_bloc.dart';

abstract class DeliveryEvent extends Equatable {
  const DeliveryEvent();

  @override
  List<Object> get props => [];
}

class LoadDeliveryTimes extends DeliveryEvent {
  const LoadDeliveryTimes();
}

class SelectDeliveryTime extends DeliveryEvent {
  const SelectDeliveryTime();
}
