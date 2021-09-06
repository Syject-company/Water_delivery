import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/profile/profile_bloc.dart';
import 'package:water/domain/service/account_service.dart';
import 'package:water/locator.dart';
import 'package:water/util/session.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

extension BlocGetter on BuildContext {
  WalletBloc get wallet => this.read<WalletBloc>();
}

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc({required ProfileBloc profile})
      : super(
          WalletLoaded(
            balance: 0.0,
          ),
        ) {
    _profileStateSubscription = profile.stream.listen((state) {
      add(LoadBalance(amount: state.walletBalance));
    });
  }

  final AccountService _accountService = locator<AccountService>();

  late final StreamSubscription _profileStateSubscription;

  @override
  Stream<WalletState> mapEventToState(
    WalletEvent event,
  ) async* {
    if (event is LoadBalance) {
      yield* _mapLoadBalanceToState(event);
    } else if (event is AddBalance) {
      yield* _mapAddBalanceToState(event);
    } else if (event is RemoveBalance) {
      yield* _mapRemoveBalanceToState(event);
    }
  }

  @override
  Future<void> close() {
    _profileStateSubscription.cancel();
    return super.close();
  }

  Stream<WalletState> _mapLoadBalanceToState(
    LoadBalance event,
  ) async* {
    yield WalletLoaded(balance: event.amount);
  }

  Stream<WalletState> _mapAddBalanceToState(
    AddBalance event,
  ) async* {
    if (Session.isAuthenticated) {
      final paymentResponse = await _accountService.topUpWallet(
        Session.token!,
        event.amount,
      );

      yield WalletTopUp(url: paymentResponse.paymentUrl);
    }
  }

  Stream<WalletState> _mapRemoveBalanceToState(
    RemoveBalance event,
  ) async* {}
}
