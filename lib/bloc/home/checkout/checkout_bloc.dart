import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/domain/model/delivery/address.dart';
import 'package:water/domain/model/delivery/time.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

extension BlocGetter on BuildContext {
  CheckoutBloc get checkout => this.read<CheckoutBloc>();
}

enum CheckoutType {
  subscription,
  order,
}

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(DeliveryAddressInput());

  @override
  Stream<CheckoutState> mapEventToState(
    CheckoutEvent event,
  ) async* {
    if (event is BackPressed) {
      yield* _mapBackPressedToState();
    } else if (event is SubmitDeliveryAddress) {
      yield* _mapSubmitDeliveryAddressToState(event);
    } else if (event is SubmitDeliveryTime) {
      yield* _mapSubmitDeliveryTimeToState(event);
    }
  }

  Stream<CheckoutState> _mapBackPressedToState() async* {
    if (state is DeliveryTimeInput) {
      yield DeliveryAddressInput();
    } else if (state is DeliveryDetailsCollected) {
      yield DeliveryTimeInput(
        address: (state as DeliveryDetailsCollected).address,
        push: false,
      );
    }
  }

  Stream<CheckoutState> _mapSubmitDeliveryAddressToState(
    SubmitDeliveryAddress event,
  ) async* {
    yield DeliveryTimeInput(
      address: event.address,
      push: true,
    );
  }

  Stream<CheckoutState> _mapSubmitDeliveryTimeToState(
    SubmitDeliveryTime event,
  ) async* {
    if (state is DeliveryTimeInput) {
      yield DeliveryDetailsCollected(
        address: (state as DeliveryTimeInput).address,
        time: event.time,
        push: true,
      );
    }
  }
}
