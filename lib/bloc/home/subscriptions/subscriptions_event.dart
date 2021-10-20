part of 'subscriptions_bloc.dart';

abstract class SubscriptionsEvent extends Equatable {
  const SubscriptionsEvent();

  @override
  List<Object> get props => [];
}

class LoadSubscriptions extends SubscriptionsEvent {
  const LoadSubscriptions({required this.language});

  final String language;

  @override
  List<Object> get props => [language];
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

class ToggleSubscriptionStatus extends SubscriptionsEvent {
  const ToggleSubscriptionStatus({required this.language});

  final String language;

  @override
  List<Object> get props => [language];
}

class DeleteSubscription extends SubscriptionsEvent {
  const DeleteSubscription({required this.language});

  final String language;

  @override
  List<Object> get props => [language];
}
