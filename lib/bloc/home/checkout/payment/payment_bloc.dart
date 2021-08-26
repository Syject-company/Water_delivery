import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/cart/cart_bloc.dart';
import 'package:water/bloc/home/wallet/wallet_bloc.dart';

part 'payment_event.dart';
part 'payment_state.dart';

extension BlocGetter on BuildContext {
  PaymentBloc get payment => this.read<PaymentBloc>();
}

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc({
    required WalletBloc wallet,
    required CartBloc cart,
  })  : _wallet = wallet,
        _cart = cart,
        super(PaymentInitial());

  final WalletBloc _wallet;
  final CartBloc _cart;

  @override
  Stream<PaymentState> mapEventToState(
    PaymentEvent event,
  ) async* {
    if (event is PayForOrder) {
      yield* _mapPayForOrderToState();
    } else if (event is PayForSubscription) {
      yield* _mapPayForSubscriptionToState(event);
    }
  }

  Stream<PaymentState> _mapPayForOrderToState() async* {
    final balance = _wallet.state.balance;
    final totalPrice = _cart.state.totalPrice;

    if (balance < totalPrice) {
      yield TopUpWallet();
      yield PaymentInitial();
    } else {
      _wallet.add(RemoveBalance(amount: totalPrice));
      _cart.add(ClearCart());
      yield SuccessfulPayment();
    }
  }

  Stream<PaymentState> _mapPayForSubscriptionToState(
    PayForSubscription event,
  ) async* {
    final balance = _wallet.state.balance;
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
