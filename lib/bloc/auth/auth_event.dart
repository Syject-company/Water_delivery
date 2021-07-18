part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class Login extends AuthEvent {
  const Login({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class Register extends AuthEvent {
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

class FacebookLogin extends AuthEvent {
  const FacebookLogin();

  @override
  List<Object> get props => [];
}

class GoogleLogin extends AuthEvent {
  const GoogleLogin();

  @override
  List<Object> get props => [];
}

class AppleLogin extends AuthEvent {
  const AppleLogin();

  @override
  List<Object> get props => [];
}
