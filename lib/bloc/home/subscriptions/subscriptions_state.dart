part of 'subscriptions_bloc.dart';

abstract class SubscriptionsState extends Equatable {
  const SubscriptionsState();

  @override
  List<Object?> get props => [];
}

class SubscriptionsInitial extends SubscriptionsState {
  const SubscriptionsInitial();
}

class SubscriptionsLoaded extends SubscriptionsState {
  const SubscriptionsLoaded({
    required this.subscriptions,
    this.selectedSubscription,
  });

  final List<Subscription> subscriptions;
  final Subscription? selectedSubscription;

  @override
  List<Object?> get props => [subscriptions, selectedSubscription];
}
