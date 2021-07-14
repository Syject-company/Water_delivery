part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthSuccess extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthError extends AuthState {
  AuthError({required this.error});

  final String error;

  @override
  List<Object> get props => [];
}
