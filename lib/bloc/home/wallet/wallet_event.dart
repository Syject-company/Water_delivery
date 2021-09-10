part of 'wallet_bloc.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object> get props => [];
}

class LoadBalance extends WalletEvent {
  const LoadBalance();
}

class UpdateBalance extends WalletEvent {
  const UpdateBalance({required this.amount});

  final double amount;

  @override
  List<Object> get props => [amount];
}

class TopUp extends WalletEvent {
  const TopUp({required this.amount});

  final double amount;

  @override
  List<Object> get props => [amount];
}
