part of 'date_bloc.dart';

abstract class DeliveryDateEvent extends Equatable {
  const DeliveryDateEvent();

  @override
  List<Object> get props => [];
}

class LoadDeliveryDates extends DeliveryDateEvent {
  const LoadDeliveryDates();
}
