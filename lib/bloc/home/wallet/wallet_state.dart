part of 'wallet_bloc.dart';

class WalletState extends Equatable {
  const WalletState({
    required this.balance,
  });

  final double balance;

  WalletState copyWith({
    double? balance,
  }) =>
      WalletState(
        balance: balance ?? this.balance,
      );

  @override
  List<Object> get props => [balance];
}
