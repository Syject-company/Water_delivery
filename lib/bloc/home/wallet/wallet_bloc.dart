import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/profile/profile_bloc.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

extension BlocGetter on BuildContext {
  WalletBloc get wallet => this.read<WalletBloc>();
}

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc({required ProfileBloc profile})
      : super(
          WalletState(
            balance: 0.0,
          ),
        ) {
    _profileStateSubscription = profile.stream.listen((state) {
      add(LoadBalance(amount: state.walletBalance));
    });
  }

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

  Stream<WalletState> _mapLoadBalanceToState(LoadBalance event) async* {
    yield state.copyWith(balance: event.amount);
  }

  Stream<WalletState> _mapAddBalanceToState(AddBalance event) async* {
    yield state.copyWith(balance: state.balance + event.amount);
  }

  Stream<WalletState> _mapRemoveBalanceToState(RemoveBalance event) async* {
    yield state.copyWith(balance: state.balance - event.amount);
  }
}
