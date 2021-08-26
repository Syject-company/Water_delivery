part of 'subscription_bloc.dart';

abstract class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();

  @override
  List<Object> get props => [];
}

class BackPressed extends SubscriptionEvent {
  const BackPressed();
}

class SubmitDeliveryAddress extends SubscriptionEvent {
  const SubmitDeliveryAddress({required this.address});

  final DeliveryAddress address;

  @override
  List<Object> get props => [address];
}

class SubmitSubscriptionDuration extends SubscriptionEvent {
  const SubmitSubscriptionDuration({required this.months});

  final int months;

  @override
  List<Object> get props => [months];
}

class SubmitDeliveryTime extends SubscriptionEvent {
  const SubmitDeliveryTime({required this.time});

  final DeliveryTime time;

  @override
  List<Object> get props => [time];
}
