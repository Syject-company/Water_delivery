part of 'delivery_bloc.dart';

class DeliveryState extends Equatable {
  const DeliveryState({
    this.address,
    this.time,
  });

  final DeliveryAddress? address;
  final DeliveryTime? time;

  DeliveryState copyWith({
    DeliveryAddress? address,
    DeliveryTime? time,
  }) =>
      DeliveryState(
        address: address ?? this.address,
        time: time ?? this.time,
      );

  @override
  List<Object?> get props => [address, time];
}
