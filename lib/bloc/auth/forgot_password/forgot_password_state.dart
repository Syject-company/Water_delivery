part of 'forgot_password_bloc.dart';

@immutable
abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();
}

class ForgotPasswordLoading extends ForgotPasswordState {
  const ForgotPasswordLoading();

  @override
  List<Object> get props => [];
}

class ForgotPasswordSuccess extends ForgotPasswordState {
  const ForgotPasswordSuccess();

  @override
  List<Object> get props => [];
}

class ForgotPasswordError extends ForgotPasswordState {
  const ForgotPasswordError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

class ForgotPasswordEmailInput extends ForgotPasswordState {
  const ForgotPasswordEmailInput();

  @override
  List<Object> get props => [];
}

class ForgotPasswordNewPasswordInput extends ForgotPasswordState {
  const ForgotPasswordNewPasswordInput({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}
