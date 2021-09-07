import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/domain/model/delivery/address.dart';
import 'package:water/domain/model/delivery/time.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

extension BlocGetter on BuildContext {
  SubscriptionBloc get subscription => this.read<SubscriptionBloc>();
}

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  SubscriptionBloc() : super(DeliveryAddressInput());

  @override
  Stream<SubscriptionState> mapEventToState(
    SubscriptionEvent event,
  ) async* {
    if (event is BackPressed) {
      yield* _mapBackPressedToState(state);
    } else if (event is SubmitDeliveryAddress) {
      yield* _mapSubmitDeliveryAddressToState(event);
    } else if (event is SubmitSubscriptionDuration) {
      yield* _mapSubmitSubscriptionDurationToState(state, event);
    } else if (event is SubmitDeliveryTime) {
      yield* _mapSubmitDeliveryTimeToState(state, event);
    }
  }

  Stream<SubscriptionState> _mapBackPressedToState(
    SubscriptionState state,
  ) async* {
    if (state is SubscriptionDetailsCollected) {
      yield DeliveryTimeInput(
        months: state.months,
        address: state.address,
        push: false,
      );
    } else if (state is DeliveryTimeInput) {
      yield SubscriptionDurationInput(
        address: state.address,
        push: false,
      );
    } else if (state is SubscriptionDurationInput) {
      yield DeliveryAddressInput();
    }
  }

  Stream<SubscriptionState> _mapSubmitDeliveryAddressToState(
    SubmitDeliveryAddress event,
  ) async* {
    yield SubscriptionDurationInput(
      address: event.address,
      push: true,
    );
  }

  Stream<SubscriptionState> _mapSubmitSubscriptionDurationToState(
    SubscriptionState state,
    SubmitSubscriptionDuration event,
  ) async* {
    if (state is SubscriptionDurationInput) {
      yield DeliveryTimeInput(
        months: event.months,
        address: state.address,
        push: true,
      );
    }
  }

  Stream<SubscriptionState> _mapSubmitDeliveryTimeToState(
    SubscriptionState state,
    SubmitDeliveryTime event,
  ) async* {
    if (state is DeliveryTimeInput) {
      yield SubscriptionDetailsCollected(
        months: state.months,
        address: state.address,
        time: event.time,
        push: true,
      );
    }
  }
}
