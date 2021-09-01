part of 'dates_bloc.dart';

class DeliveryDatesState extends Equatable {
  const DeliveryDatesState({required this.dates});

  final List<DeliveryDate> dates;

  DeliveryDatesState copyWith({
    List<DeliveryDate>? dates,
  }) =>
      DeliveryDatesState(
        dates: dates ?? this.dates,
      );

  @override
  List<Object> get props => [dates];
}
