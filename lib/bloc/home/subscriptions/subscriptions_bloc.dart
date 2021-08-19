import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/domain/model/home/data/categories.dart';
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
        title: categories[2].products[1].title,
        volume: categories[2].products[1].volume,
        amount: 1,
        price: categories[2].products[1].price,
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
        title: categories[3].products[1].title,
        volume: categories[3].products[1].volume,
        amount: 3,
        price: categories[3].products[1].price,
      ),
      SubscriptionProduct(
        title: categories[1].products[0].title,
        volume: categories[1].products[0].volume,
        amount: 7,
        price: categories[1].products[0].price,
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
