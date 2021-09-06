part of 'wallet_bloc.dart';

abstract class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object> get props => [];
}

class WalletLoaded extends WalletState {
  const WalletLoaded({
    required this.balance,
  });

  final double balance;

  @override
  List<Object> get props => [balance];
}

class WalletTopUp extends WalletState {
  const WalletTopUp({
    required this.url,
  });

  final String url;

  @override
  List<Object> get props => [url];
}
