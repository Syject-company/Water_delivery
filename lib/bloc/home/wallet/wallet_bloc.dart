import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wallet_event.dart';

part 'wallet_state.dart';

extension BlocGetter on BuildContext {
  WalletBloc get wallet => this.read<WalletBloc>();
}

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(WalletState(balance: 0.0));

  @override
  Stream<WalletState> mapEventToState(
    WalletEvent event,
  ) async* {
    if (event is AddBalance) {
      yield* _mapAddBalanceToState(event);
    }
  }

  Stream<WalletState> _mapAddBalanceToState(AddBalance event) async* {
    yield state.copyWith(balance: state.balance + event.amount);
  }
}
