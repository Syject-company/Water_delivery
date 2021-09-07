import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/cart/cart_bloc.dart';
import 'package:water/bloc/home/profile/profile_bloc.dart';
import 'package:water/domain/model/cart/cart_item.dart';
import 'package:water/domain/model/delivery/address.dart';
import 'package:water/domain/model/delivery/date.dart';
import 'package:water/domain/model/order/order_form.dart';
import 'package:water/domain/model/order/order_product_form.dart';
import 'package:water/domain/model/subscription/subscription_form.dart';
import 'package:water/domain/service/order_service.dart';
import 'package:water/domain/service/subscription_service.dart';
import 'package:water/locator.dart';
import 'package:water/util/session.dart';

part 'payment_event.dart';

part 'payment_state.dart';

extension BlocGetter on BuildContext {
  PaymentBloc get payment => this.read<PaymentBloc>();
}

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc({
    required ProfileBloc profile,
    required CartBloc cart,
  })  : _profile = profile,
        _cart = cart,
        super(PaymentInitial());

  final OrderService _orderService = locator<OrderService>();
  final SubscriptionService _subscriptionService =
      locator<SubscriptionService>();

  final ProfileBloc _profile;
  final CartBloc _cart;

  @override
  Stream<PaymentState> mapEventToState(
    PaymentEvent event,
  ) async* {
    if (event is PayForOrder) {
      yield* _mapPayForOrderToState(event);
    } else if (event is PayForSubscription) {
      yield* _mapPayForSubscriptionToState(event);
    }
  }

  Stream<PaymentState> _mapPayForOrderToState(
    PayForOrder event,
  ) async* {
    yield PaymentInitial();

    final balance = _profile.state.walletBalance;
    final totalPrice = _cart.state.totalPrice;

    if (balance < totalPrice) {
      yield TopUpWallet();
      return;
    }

    yield PaymentProcessing();
    final form = OrderForm(
      deliveryDate: DateFormat('yyyy-MM-dd').format(event.time.date),
      periodId: '1',
      promo: '',
      products: event.items.map((item) {
        return OrderProductForm(
          id: item.product.id,
          amount: item.amount,
        );
      }).toList(),
      city: event.address.city,
      district: event.address.district,
      street: event.address.street,
      building: event.address.building,
      floor: event.address.floor,
      apartment: event.address.apartment,
    );
    await _orderService.create(Session.token!, form);

    _cart.add(ClearCart());
    yield SuccessfulPayment();
  }

  Stream<PaymentState> _mapPayForSubscriptionToState(
    PayForSubscription event,
  ) async* {
    yield PaymentInitial();

    final balance = _profile.state.walletBalance;
    final totalPrice = _cart.state.totalPrice * (event.months * 4);

    if (balance < totalPrice) {
      yield TopUpWallet();
      return;
    }

    yield PaymentProcessing();
    final form = SubscriptionForm(
      deliveryDate: DateFormat('yyyy-MM-dd').format(event.time.date),
      periodId: event.time.period.id,
      months: event.months,
      promo: '123',
      products: event.items.map((item) {
        return SubscriptionProductForm(
          id: item.product.id,
          amount: item.amount,
        );
      }).toList(),
      city: event.address.city,
      district: event.address.district,
      street: event.address.street,
      building: event.address.building,
      floor: event.address.floor,
      apartment: event.address.apartment,
    );
    _subscriptionService.create(Session.token!, form);

    _cart.add(ClearCart());
    yield SuccessfulPayment();
  }
}
