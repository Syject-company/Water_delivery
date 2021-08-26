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
      yield* _mapBackPressedToState();
    } else if (event is SubmitDeliveryAddress) {
      yield* _mapSubmitDeliveryAddressToState(event);
    } else if (event is SubmitSubscriptionDuration) {
      yield* _mapSubmitSubscriptionDurationToState(event);
    } else if (event is SubmitDeliveryTime) {
      yield* _mapSubmitDeliveryTimeToState(event);
    }
  }

  Stream<SubscriptionState> _mapBackPressedToState() async* {
    if (state is SubscriptionDetailsCollected) {
      yield DeliveryTimeInput(
        months: (state as SubscriptionDetailsCollected).months,
        address: (state as SubscriptionDetailsCollected).address,
        push: false,
      );
    } else if (state is DeliveryTimeInput) {
      yield SubscriptionDurationInput(
        address: (state as DeliveryTimeInput).address,
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
    SubmitSubscriptionDuration event,
  ) async* {
    if (state is SubscriptionDurationInput) {
      yield DeliveryTimeInput(
        months: event.months,
        address: (state as SubscriptionDurationInput).address,
        push: true,
      );
    }
  }

  Stream<SubscriptionState> _mapSubmitDeliveryTimeToState(
    SubmitDeliveryTime event,
  ) async* {
    if (state is DeliveryTimeInput) {
      yield SubscriptionDetailsCollected(
        months: (state as DeliveryTimeInput).months,
        address: (state as DeliveryTimeInput).address,
        time: event.time,
        push: true,
      );
    }
  }
}
