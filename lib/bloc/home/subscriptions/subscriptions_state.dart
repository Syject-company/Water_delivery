part of 'subscriptions_bloc.dart';

abstract class SubscriptionsState extends Equatable {
  const SubscriptionsState();

  @override
  List<Object> get props => [];
}

class SubscriptionsInitial extends SubscriptionsState {
  const SubscriptionsInitial();
}

class SubscriptionsLoaded extends SubscriptionsState {
  const SubscriptionsLoaded({required this.subscriptions});

  final List<Subscription> subscriptions;

  @override
  List<Object> get props => [subscriptions];
}
