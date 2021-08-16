import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/domain/model/home/subscription/subscription.dart';

part 'subscriptions_event.dart';
part 'subscriptions_state.dart';

extension BlocGetter on BuildContext {
  SubscriptionsBloc get subscriptions => this.read<SubscriptionsBloc>();
}

class SubscriptionsBloc extends Bloc<SubscriptionsEvent, SubscriptionsState> {
  SubscriptionsBloc() : super(SubscriptionsInitial());

  @override
  Stream<SubscriptionsState> mapEventToState(
    SubscriptionsEvent event,
  ) async* {
    if (event is LoadSubscriptions) {
      yield* _mapLoadSubscriptionsToState(event);
    }
  }

  Stream<SubscriptionsState> _mapLoadSubscriptionsToState(
    LoadSubscriptions event,
  ) async* {
    yield SubscriptionsLoaded(subscriptions: _subscriptions);
  }
}

const List<Subscription> _subscriptions = [
  Subscription(
    id: '1',
    isActive: true,
    deliveryDate: '16-08-2021',
    products: [
      SubscriptionProduct(
        title: 'Title 1',
        volume: 1.5,
        amount: 2,
        price: 12.0,
      ),
      SubscriptionProduct(
        title: 'Title 2',
        volume: 0.5,
        amount: 1,
        price: 24.0,
      ),
    ],
    city: 'City 1',
    district: 'District 1',
    street: 'Street 1',
    building: 'Building 1',
    apartment: 'Apartment 1',
    floor: 'Floor 1',
  ),
  Subscription(
    id: '2',
    isActive: false,
    deliveryDate: '12-08-2021',
    products: [
      SubscriptionProduct(
        title: 'Title 1',
        volume: 200,
        amount: 5,
        price: 38.0,
      ),
    ],
    city: 'City 2',
    district: 'District 2',
    street: 'Street 2',
    building: 'Building 2',
    apartment: 'Apartment 2',
    floor: 'Floor 2',
  )
];
