part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();
}

class SignInInitial extends SignInState {
  @override
  List<Object> get props => [];
}

class SignInSuccess extends SignInState {
  @override
  List<Object> get props => [];
}

class SignInError extends SignInState {
  SignInError({required this.error});

  final String error;

  @override
  List<Object> get props => [];
}
