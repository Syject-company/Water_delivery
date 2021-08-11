part of 'delivery_bloc.dart';

abstract class DeliveryState extends Equatable {
  const DeliveryState();

  @override
  List<Object> get props => [];
}

class DeliveryTimesLoaded extends DeliveryState {
  const DeliveryTimesLoaded({required this.times});

  final List<DeliveryTime> times;

  @override
  List<Object> get props => [times];
}

class DeliveryTimeSelected extends DeliveryState {
  const DeliveryTimeSelected({required this.time});

  final DeliveryTime time;

  @override
  List<Object> get props => [time];
}
