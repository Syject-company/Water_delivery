import 'dart:async';
import 'dart:io';

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
      : _profile = profile,
        super(
          WalletLoaded(
            balance: 0.0,
          ),
        ) {
    _profileStateSubscription = profile.stream.listen((state) {
      add(UpdateBalance(amount: state.walletBalance));
    });
  }

  final ProfileBloc _profile;

  final AccountService _accountService = locator<AccountService>();

  late final StreamSubscription _profileStateSubscription;

  @override
  Stream<WalletState> mapEventToState(
    WalletEvent event,
  ) async* {
    if (event is LoadBalance) {
      yield* _mapLoadBalanceToState();
    } else if (event is UpdateBalance) {
      yield* _mapUpdateBalanceToState(event);
    } else if (event is TopUp) {
      yield* _mapTopUpToState(event);
    }
  }

  @override
  Future<void> close() {
    _profileStateSubscription.cancel();
    return super.close();
  }

  Stream<WalletState> _mapLoadBalanceToState() async* {
    yield WalletLoaded(balance: _profile.state.walletBalance);
  }

  Stream<WalletState> _mapUpdateBalanceToState(
    UpdateBalance event,
  ) async* {
    yield WalletLoaded(balance: event.amount);
  }

  Stream<WalletState> _mapTopUpToState(
    TopUp event,
  ) async* {
    try {
      if (Session.isAuthenticated) {
        yield TopUpWalletRequest();

        final paymentResponse = await _accountService.topUpWallet(
          Session.token!,
          event.amount,
        );

        yield TopUpWalletView(url: paymentResponse.paymentUrl);
      }
    } on HttpException catch (_) {
      yield TopUpWalletError();
    }
  }
}
