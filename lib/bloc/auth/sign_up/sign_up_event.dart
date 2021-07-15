part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class Register extends SignUpEvent {
  const Register({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  final String email;
  final String password;
  final String confirmPassword;

  @override
  List<Object> get props => [email, password, confirmPassword];
}