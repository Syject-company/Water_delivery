part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
}

class SignUpInitial extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpSuccess extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpError extends SignUpState {
  SignUpError({required this.error});

  final String error;

  @override
  List<Object> get props => [];
}