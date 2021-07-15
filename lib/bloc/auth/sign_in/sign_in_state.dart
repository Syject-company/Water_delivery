part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();
}

class SignInInitial extends SignInState {
  const SignInInitial();

  @override
  List<Object> get props => [];
}

class SignInLoading extends SignInState {
  const SignInLoading();

  @override
  List<Object> get props => [];
}

class SignInSuccess extends SignInState {
  const SignInSuccess();

  @override
  List<Object> get props => [];
}

class SignInError extends SignInState {
  const SignInError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}