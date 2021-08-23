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
    } else if (event is SelectSubscription) {
      yield* _mapSelectSubscriptionToState(event);
    } else if (event is DeselectSubscription) {
      yield* _mapDeselectSubscriptionToState();
    }
  }

  Stream<SubscriptionsState> _mapLoadSubscriptionsToState(
    LoadSubscriptions event,
  ) async* {
    yield SubscriptionsLoaded(subscriptions: _subscriptions);
  }

  Stream<SubscriptionsState> _mapSelectSubscriptionToState(
    SelectSubscription event,
  ) async* {
    if (state is SubscriptionsLoaded) {
      yield SubscriptionsLoaded(
        subscriptions: _subscriptions,
        selectedSubscription: event.subscription,
      );
    }
  }

  Stream<SubscriptionsState> _mapDeselectSubscriptionToState() async* {
    if (state is SubscriptionsLoaded) {
      yield SubscriptionsLoaded(
        subscriptions: _subscriptions,
      );
    }
  }
}

final List<Subscription> _subscriptions = [
  Subscription(
    id: '1',
    isActive: true,
    deliveryDate: '16-08-2021',
    products: [
      SubscriptionProduct(
        title: 'Title 1',
        volume: 0.33,
        amount: 1,
        price: 12.0,
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
        volume: 0.1,
        amount: 10,
        price: 17.0,
      ),
      SubscriptionProduct(
        title: 'Title 1',
        volume: 0.5,
        amount: 3,
        price: 10.0,
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
