import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/domain/model/order/order.dart';
import 'package:water/domain/service/order_service.dart';
import 'package:water/locator.dart';
import 'package:water/util/session.dart';

part 'orders_event.dart';
part 'orders_state.dart';

extension BlocGetter on BuildContext {
  OrdersBloc get orders => this.read<OrdersBloc>();
}

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(OrdersInitial());

  final OrderService _orderService = locator<OrderService>();

  @override
  Stream<OrdersState> mapEventToState(
    OrdersEvent event,
  ) async* {
    if (event is LoadOrders) {
      yield* _mapLoadSubscriptionsToState(event);
    }
  }

  Stream<OrdersState> _mapLoadSubscriptionsToState(
    LoadOrders event,
  ) async* {
    try {
      if (Session.isAuthenticated) {
        yield OrdersLoading();
        final orders = await _orderService.getAll(Session.token!);
        yield OrdersLoaded(orders: orders);
      }
    } catch (_) {
      yield OrdersError();
    }
  }
}
