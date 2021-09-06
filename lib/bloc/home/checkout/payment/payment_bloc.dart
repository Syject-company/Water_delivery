import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/cart/cart_bloc.dart';
import 'package:water/bloc/home/profile/profile_bloc.dart';
import 'package:water/bloc/home/wallet/wallet_bloc.dart';
import 'package:water/domain/model/cart/cart_item.dart';
import 'package:water/domain/model/delivery/address.dart';
import 'package:water/domain/model/delivery/date.dart';
import 'package:water/domain/model/order/order_form.dart';
import 'package:water/domain/model/order/order_product_form.dart';
import 'package:water/domain/service/order_service.dart';
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
    required WalletBloc wallet,
    required CartBloc cart,
  })  : _profile = profile,
        _wallet = wallet,
        _cart = cart,
        super(PaymentInitial());

  final OrderService _orderService = locator<OrderService>();

  final ProfileBloc _profile;
  final WalletBloc _wallet;
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
    final balance = _profile.state.walletBalance;
    final totalPrice = _cart.state.totalPrice;

    if (balance < totalPrice) {
      yield TopUpWallet();
      yield PaymentInitial();
      return;
    }

    final form = OrderForm(
      deliveryDate: DateFormat('yyyy-MM-dd').format(event.time.date),
      periodId: event.time.period.id,
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

    _orderService.create(Session.token!, form);
  }

  Stream<PaymentState> _mapPayForSubscriptionToState(
    PayForSubscription event,
  ) async* {
    final balance = _profile.state.walletBalance;
    final totalPrice = _cart.state.totalPrice * (event.months * 4);

    if (balance < totalPrice) {
      yield TopUpWallet();
      yield PaymentInitial();
    } else {
      _wallet.add(RemoveBalance(amount: totalPrice));
      _cart.add(ClearCart());
      yield SuccessfulPayment();
    }
  }
}
