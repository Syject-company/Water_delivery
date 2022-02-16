part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

class ForgotPasswordLoading extends ForgotPasswordState {
  const ForgotPasswordLoading();
}

class ForgotPasswordSuccess extends ForgotPasswordState {
  const ForgotPasswordSuccess();
}

class ForgotPasswordError extends ForgotPasswordState {
  const ForgotPasswordError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

class EmailInput extends ForgotPasswordState {
  const EmailInput();
}

class NewPasswordInput extends ForgotPasswordState {
  const NewPasswordInput({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}
