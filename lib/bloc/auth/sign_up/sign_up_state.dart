part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
}

class SignUpInitial extends SignUpState {
  const SignUpInitial();

  @override
  List<Object> get props => [];
}

class SignUpLoading extends SignUpState {
  const SignUpLoading();

  @override
  List<Object> get props => [];
}

class SignUpSuccess extends SignUpState {
  const SignUpSuccess();

  @override
  List<Object> get props => [];
}

class SignUpError extends SignUpState {
  const SignUpError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
