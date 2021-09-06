part of 'dates_bloc.dart';

abstract class DeliveryDatesEvent extends Equatable {
  const DeliveryDatesEvent();

  @override
  List<Object> get props => [];
}

class LoadDeliveryDates extends DeliveryDatesEvent {
  const LoadDeliveryDates({required this.city});

  final String city;

  @override
  List<Object> get props => [city];
}
