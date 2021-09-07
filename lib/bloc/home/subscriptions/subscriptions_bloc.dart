import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/domain/model/subscription/subscription.dart';
import 'package:water/domain/service/subscription_service.dart';
import 'package:water/locator.dart';
import 'package:water/util/nullable.dart';
import 'package:water/util/session.dart';

part 'subscriptions_event.dart';
part 'subscriptions_state.dart';

extension BlocGetter on BuildContext {
  SubscriptionsBloc get subscriptions => this.read<SubscriptionsBloc>();
}

class SubscriptionsBloc extends Bloc<SubscriptionsEvent, SubscriptionsState> {
  SubscriptionsBloc() : super(SubscriptionsInitial());

  final SubscriptionService _subscriptionService =
      locator<SubscriptionService>();

  @override
  Stream<SubscriptionsState> mapEventToState(
    SubscriptionsEvent event,
  ) async* {
    if (event is LoadSubscriptions) {
      yield* _mapLoadSubscriptionsToState(event);
    } else if (event is SelectSubscription) {
      yield* _mapSelectSubscriptionToState(state, event);
    } else if (event is DeselectSubscription) {
      yield* _mapDeselectSubscriptionToState(state);
    } else if (event is StopSubscription) {
      yield* _mapStopSubscriptionToState(state);
    } else if (event is DeleteSubscription) {
      yield* _mapDeleteSubscriptionToState(state);
    }
  }

  Stream<SubscriptionsState> _mapLoadSubscriptionsToState(
    LoadSubscriptions event,
  ) async* {
    if (Session.isAuthenticated) {
      yield SubscriptionsLoading();
      final subscriptions = await _subscriptionService.getAll(Session.token!);
      yield SubscriptionsLoaded(subscriptions: subscriptions);
    }
  }

  Stream<SubscriptionsState> _mapSelectSubscriptionToState(
    SubscriptionsState state,
    SelectSubscription event,
  ) async* {
    if (state is SubscriptionsLoaded) {
      yield state.copyWith(
        selectedSubscription: Nullable(event.subscription),
      );
    }
  }

  Stream<SubscriptionsState> _mapDeselectSubscriptionToState(
    SubscriptionsState state,
  ) async* {
    if (state is SubscriptionsLoaded) {
      yield state.copyWith(
        selectedSubscription: Nullable(null),
      );
    }
  }

  Stream<SubscriptionsState> _mapStopSubscriptionToState(
    SubscriptionsState state,
  ) async* {
    if (state is SubscriptionsLoaded) {
      final subscription = state.selectedSubscription;

      if (subscription == null) {
        return;
      }

      print('Stop subscription: ${subscription.id}');
      await _subscriptionService.stop(Session.token!, subscription.id);
      add(LoadSubscriptions());
    }
  }

  Stream<SubscriptionsState> _mapDeleteSubscriptionToState(
    SubscriptionsState state,
  ) async* {
    if (state is SubscriptionsLoaded) {
      final subscription = state.selectedSubscription;

      if (subscription == null) {
        return;
      }

      print('Delete subscription: ${subscription.id}');
      await _subscriptionService.delete(Session.token!, subscription.id);
      add(LoadSubscriptions());
    }
  }
}
