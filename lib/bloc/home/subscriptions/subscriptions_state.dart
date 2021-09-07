part of 'subscriptions_bloc.dart';

abstract class SubscriptionsState extends Equatable {
  const SubscriptionsState();

  @override
  List<Object?> get props => [];
}

class SubscriptionsInitial extends SubscriptionsState {
  const SubscriptionsInitial();
}

class SubscriptionsLoading extends SubscriptionsState {
  const SubscriptionsLoading();
}

class SubscriptionsLoaded extends SubscriptionsState {
  const SubscriptionsLoaded({
    required this.subscriptions,
    this.selectedSubscription,
  });

  final List<Subscription> subscriptions;
  final Subscription? selectedSubscription;

  SubscriptionsLoaded copyWith({
    List<Subscription>? subscriptions,
    Nullable<Subscription>? selectedSubscription,
  }) =>
      SubscriptionsLoaded(
        subscriptions: subscriptions ?? this.subscriptions,
        selectedSubscription: selectedSubscription != null
            ? selectedSubscription.value
            : this.selectedSubscription,
      );

  @override
  List<Object?> get props => [
        subscriptions,
        selectedSubscription,
      ];
}
