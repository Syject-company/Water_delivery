import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/domain/model/home/order/order.dart';

part 'orders_event.dart';

part 'orders_state.dart';

extension BlocGetter on BuildContext {
  OrdersBloc get orders => this.read<OrdersBloc>();
}

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(OrdersInitial());

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
    yield OrdersLoaded(orders: _orders);
  }
}

final List<Order> _orders = [
  Order(
    id: '1',
    status: 'Created',
    deliveryDate: '2021-08-16',
    createdDate: '2021-08-16',
    products: [
      OrderProduct(
        title: 'Title 1',
        volume: 0.33,
        amount: 2,
        price: 12.0,
      ),
      OrderProduct(
        title: 'Title 2',
        volume: 0.5,
        amount: 4,
        price: 24.0,
      ),
    ],
    customerName: 'Customer Name 1',
    isSubscribed: false,
    city: 'City 1',
    district: 'District 1',
    street: 'Street 1',
    building: 'Building 1',
    apartment: 'Apartment 1',
    floor: 'Floor 1',
  ),
  Order(
    id: '2',
    status: 'Paid',
    deliveryDate: '2021-08-14',
    createdDate: '2021-08-14',
    products: [
      OrderProduct(
        title: 'Title 3',
        volume: 1.5,
        amount: 7,
        price: 16.0,
      ),
    ],
    customerName: 'Customer Name 2',
    isSubscribed: true,
    city: 'City 2',
    district: 'District 2',
    street: 'Street 2',
    building: 'Building 2',
    apartment: 'Apartment 2',
    floor: 'Floor 2',
  )
];
