import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/domain/model/home/delivery/address.dart';
import 'package:water/domain/model/home/delivery/time.dart';

part 'delivery_event.dart';
part 'delivery_state.dart';

extension BlocGetter on BuildContext {
  DeliveryBloc get delivery => this.read<DeliveryBloc>();
}

class DeliveryBloc extends Bloc<DeliveryEvent, DeliveryState> {
  DeliveryBloc() : super(DeliveryAddressInput());

  @override
  Stream<DeliveryState> mapEventToState(
    DeliveryEvent event,
  ) async* {
    if (event is BackPressed) {
      yield* _mapBackPressedToState();
    } else if (event is SubmitDeliveryAddress) {
      yield* _mapSubmitDeliveryAddressToState(event);
    } else if (event is SubmitDeliveryTime) {
      yield* _mapSubmitDeliveryTimeToState(event);
    }
  }

  Stream<DeliveryState> _mapBackPressedToState() async* {
    if (state is DeliveryTimeInput) {
      yield DeliveryAddressInput();
    } else if (state is DeliveryDetailsCollected) {
      yield DeliveryTimeInput(
        address: (state as DeliveryDetailsCollected).address,
        push: false,
      );
    }
  }

  Stream<DeliveryState> _mapSubmitDeliveryAddressToState(
    SubmitDeliveryAddress event,
  ) async* {
    yield DeliveryTimeInput(
      address: event.address,
      push: true,
    );
  }

  Stream<DeliveryState> _mapSubmitDeliveryTimeToState(
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
