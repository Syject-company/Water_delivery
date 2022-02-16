import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/domain/model/delivery/address.dart';
import 'package:water/domain/model/delivery/time.dart';

part 'order_event.dart';
part 'order_state.dart';

extension BlocGetter on BuildContext {
  OrderBloc get order => this.read<OrderBloc>();
}

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(DeliveryAddressInput());

  @override
  Stream<OrderState> mapEventToState(
    OrderEvent event,
  ) async* {
    if (event is BackPressed) {
      yield* _mapBackPressedToState(state);
    } else if (event is SubmitDeliveryAddress) {
      yield* _mapSubmitDeliveryAddressToState(event);
    } else if (event is SubmitDeliveryTime) {
      yield* _mapSubmitDeliveryTimeToState(event, state);
    }
  }

  Stream<OrderState> _mapBackPressedToState(
    OrderState state,
  ) async* {
    if (state is OrderDetailsCollected) {
      yield DeliveryTimeInput(
        address: state.address,
        push: false,
      );
    } else if (state is DeliveryTimeInput) {
      yield DeliveryAddressInput();
    }
  }

  Stream<OrderState> _mapSubmitDeliveryAddressToState(
    SubmitDeliveryAddress event,
  ) async* {
    yield DeliveryTimeInput(
      address: event.address,
      push: true,
    );
  }

  Stream<OrderState> _mapSubmitDeliveryTimeToState(
    SubmitDeliveryTime event,
    OrderState state,
  ) async* {
    if (state is DeliveryTimeInput) {
      yield OrderDetailsCollected(
        address: state.address,
        time: event.time,
        push: true,
      );
    }
  }
}
