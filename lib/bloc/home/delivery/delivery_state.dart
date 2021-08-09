part of 'delivery_bloc.dart';

abstract class DeliveryState extends Equatable {
  const DeliveryState();

  @override
  List<Object> get props => [];
}

class DeliveryInitial extends DeliveryState {
  const DeliveryInitial();
}

class DeliveryTimesLoaded extends DeliveryState {
  const DeliveryTimesLoaded({required this.times});

  final List<DeliveryTime> times;

  @override
  List<Object> get props => [times];
}
