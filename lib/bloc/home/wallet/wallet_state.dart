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

class TopUpWalletRequest extends WalletState {
  const TopUpWalletRequest();
}

class TopUpWalletView extends WalletState {
  const TopUpWalletView({
    required this.url,
  });

  final String url;

  @override
  List<Object> get props => [url];
}

class TopUpWalletSuccess extends WalletState {
  const TopUpWalletSuccess();
}

class TopUpWalletError extends WalletState {
  const TopUpWalletError();
}
