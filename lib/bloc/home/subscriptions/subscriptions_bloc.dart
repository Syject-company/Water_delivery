import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/domain/model/subscription/subscription.dart';
import 'package:water/domain/services/subscription_service.dart';
import 'package:water/locator.dart';
import 'package:water/utils/nullable.dart';
import 'package:water/utils/session.dart';

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
      yield* _mapLoadSubscriptionsToState(state, event);
    } else if (event is SelectSubscription) {
      yield* _mapSelectSubscriptionToState(state, event);
    } else if (event is DeselectSubscription) {
      yield* _mapDeselectSubscriptionToState(state);
    } else if (event is ToggleSubscriptionStatus) {
      yield* _mapToggleSubscriptionStatusToState(state, event);
    } else if (event is DeleteSubscription) {
      yield* _mapDeleteSubscriptionToState(state, event);
    }
  }

  Stream<SubscriptionsState> _mapLoadSubscriptionsToState(
    SubscriptionsState state,
    LoadSubscriptions event,
  ) async* {
    try {
      if (Session.isAuthenticated) {
        yield SubscriptionsLoading();
        final subscriptions = await _subscriptionService.getAll(
          Session.token!,
          // event.language,
        );
        yield SubscriptionsLoaded(subscriptions: subscriptions);
      }
    } catch (_) {
      yield SubscriptionsError();
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

  Stream<SubscriptionsState> _mapToggleSubscriptionStatusToState(
    SubscriptionsState state,
    ToggleSubscriptionStatus event,
  ) async* {
    try {
      if (state is SubscriptionsLoaded) {
        final subscription = state.selectedSubscription;
        if (subscription == null) {
          return;
        }

        yield SubscriptionsToggleStatusRequest();

        await _subscriptionService.toggleStatus(
          Session.token!,
          subscription.id,
        );

        add(LoadSubscriptions(language: event.language));
      }
    } catch (_) {
      yield SubscriptionsError();
    }
  }

  Stream<SubscriptionsState> _mapDeleteSubscriptionToState(
    SubscriptionsState state,
    DeleteSubscription event,
  ) async* {
    try {
      if (state is SubscriptionsLoaded) {
        final subscription = state.selectedSubscription;
        if (subscription == null) {
          return;
        }

        yield SubscriptionsDeleteRequest();

        await _subscriptionService.delete(
          Session.token!,
          subscription.id,
        );

        add(LoadSubscriptions(language: event.language));
      }
    } catch (_) {
      yield SubscriptionsError();
    }
  }
}
