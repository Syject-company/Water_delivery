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
import 'package:water/domain/services/order_service.dart';
import 'package:water/domain/services/subscription_service.dart';
import 'package:water/locator.dart';
import 'package:water/utils/session.dart';

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

  final ProfileBloc _profile;
  final CartBloc _cart;

  final OrderService _orderService = locator<OrderService>();
  final SubscriptionService _subscriptionService =
      locator<SubscriptionService>();

  @override
  Stream<PaymentState> mapEventToState(
    PaymentEvent event,
  ) async* {
    if (event is PayForOrder) {
      yield* _mapPayForOrderToState(event);
    } else if (event is PayForSubscription) {
      yield* _mapPayForSubscriptionToState(event);
    } else if (event is FinishPayment) {
      yield* _mapFinishPaymentToState();
    }
  }

  Stream<PaymentState> _mapPayForOrderToState(
    PayForOrder event,
  ) async* {
    try {
      yield OrderPaymentRequest();

      final form = OrderForm(
        deliveryDate: DateFormat('yyyy-MM-dd').format(event.time.date),
        periodId: event.time.period.id,
        promoCode: event.promoCode,
        products: event.items.map((item) {
          return OrderProductForm(
            id: item.product.id,
            amount: item.amount,
          );
        }).toList(growable: false),
        city: event.address.city,
        district: event.address.district,
        street: event.address.street,
        building: event.address.building,
        floor: event.address.floor,
        apartment: event.address.apartment,
      );
      final paymentResponse = await _orderService.create(
        Session.token!,
        form,
      );

      yield OrderPaymentView(url: paymentResponse.paymentUrl);
    } catch (_) {
      yield PaymentError();
    }
  }

  Stream<PaymentState> _mapPayForSubscriptionToState(
    PayForSubscription event,
  ) async* {
    try {
      yield PaymentInitial();

      final balance = _profile.state.walletBalance;
      final totalPrice = _cart.state.totalPrice;

      if (balance < totalPrice) {
        yield TopUpWallet();
        return;
      }

      yield SubscriptionPaymentRequest();

      final form = SubscriptionForm(
        deliveryDate: DateFormat('yyyy-MM-dd').format(event.time.date),
        periodId: event.time.period.id,
        promoCode: event.promoCode,
        months: event.months,
        products: event.items.map((item) {
          return SubscriptionProductForm(
            id: item.product.id,
            amount: item.amount,
          );
        }).toList(growable: false),
        city: event.address.city,
        district: event.address.district,
        street: event.address.street,
        building: event.address.building,
        floor: event.address.floor,
        apartment: event.address.apartment,
      );
      await _subscriptionService.create(
        Session.token!,
        form,
      );

      add(FinishPayment());
    } catch (_) {
      yield PaymentError();
    }
  }

  Stream<PaymentState> _mapFinishPaymentToState() async* {
    _profile.add(UpdateProfile());
    _cart.add(ClearCart());

    yield SuccessfulPayment();
  }
}
