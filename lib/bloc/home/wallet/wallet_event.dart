part of 'wallet_bloc.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object> get props => [];
}

class AddBalance extends WalletEvent {
  const AddBalance({required this.amount});

  final double amount;

  @override
  List<Object> get props => [amount];
}
