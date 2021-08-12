part of 'date_bloc.dart';

class DeliveryDateState extends Equatable {
  const DeliveryDateState();

  @override
  List<Object> get props => [];
}

class DeliveryTimeInitial extends DeliveryDateState {
  const DeliveryTimeInitial();
}

class DeliveryDatesLoaded extends DeliveryDateState {
  const DeliveryDatesLoaded({required this.dates});

  final List<DeliveryDate> dates;

  @override
  List<Object> get props => [dates];
}
