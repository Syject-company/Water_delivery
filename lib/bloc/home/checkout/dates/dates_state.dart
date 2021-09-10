part of 'dates_bloc.dart';

abstract class DeliveryDatesState extends Equatable {
  const DeliveryDatesState();

  @override
  List<Object> get props => [];
}

class DeliveryDatesInitial extends DeliveryDatesState {
  const DeliveryDatesInitial();
}

class DeliveryDatesLoading extends DeliveryDatesState {
  const DeliveryDatesLoading();
}

class DeliveryDatesLoaded extends DeliveryDatesState {
  const DeliveryDatesLoaded({required this.dates});

  final List<DeliveryDate> dates;

  @override
  List<Object> get props => [dates];
}