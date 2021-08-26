part of 'subscription_bloc.dart';

abstract class SubscriptionState extends Equatable {
  const SubscriptionState();

  @override
  List<Object> get props => [];
}

class DeliveryAddressInput extends SubscriptionState {
  const DeliveryAddressInput();
}

class SubscriptionDurationInput extends SubscriptionState {
  const SubscriptionDurationInput({
    required this.address,
    required this.push,
  });

  final DeliveryAddress address;
  final bool push;

  @override
  List<Object> get props => [address];
}

class DeliveryTimeInput extends SubscriptionState {
  const DeliveryTimeInput({
    required this.months,
    required this.address,
    required this.push,
  });

  final int months;
  final DeliveryAddress address;
  final bool push;

  @override
  List<Object> get props => [
        months,
        address,
      ];
}

class SubscriptionDetailsCollected extends SubscriptionState {
  const SubscriptionDetailsCollected({
    required this.months,
    required this.address,
    required this.time,
    required this.push,
  });

  final int months;
  final DeliveryAddress address;
  final DeliveryTime time;
  final bool push;

  @override
  List<Object> get props => [
        months,
        address,
        time,
      ];
}
