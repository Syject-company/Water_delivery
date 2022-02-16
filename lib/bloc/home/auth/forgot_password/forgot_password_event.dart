part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ResetPassword extends ForgotPasswordEvent {
  const ResetPassword({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class ConfirmNewPassword extends ForgotPasswordEvent {
  const ConfirmNewPassword({
    required this.code,
    required this.password,
    required this.confirmPassword,
  });

  final String code;
  final String password;
  final String confirmPassword;

  @override
  List<Object> get props => [
        code,
        password,
        confirmPassword,
      ];
}
