part of 'subscriptions_bloc.dart';

abstract class SubscriptionsEvent extends Equatable {
  const SubscriptionsEvent();

  @override
  List<Object> get props => [];
}

class LoadSubscriptions extends SubscriptionsEvent {
  const LoadSubscriptions();
}

class SelectSubscription extends SubscriptionsEvent {
  const SelectSubscription({required this.subscription});

  final Subscription subscription;

  @override
  List<Object> get props => [subscription];
}

class DeselectSubscription extends SubscriptionsEvent {
  const DeselectSubscription();
}

class StopSubscription extends SubscriptionsEvent {
  const StopSubscription();
}

class DeleteSubscription extends SubscriptionsEvent {
  const DeleteSubscription();
}
