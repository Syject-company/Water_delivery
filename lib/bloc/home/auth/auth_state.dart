part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}

class Authenticating extends AuthState {
  const Authenticating();
}

class Authenticated extends AuthState {
  const Authenticated();
}

class AuthenticationFailed extends AuthState {
  const AuthenticationFailed({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
