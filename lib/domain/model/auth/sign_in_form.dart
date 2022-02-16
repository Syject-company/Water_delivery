import 'package:equatable/equatable.dart';

class SignInFormFields {
  static const String email = 'email';
  static const String password = 'password';
}

class SignInForm extends Equatable {
  SignInForm({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  Map<String, dynamic> toJson() {
    return {
      SignInFormFields.email: email,
      SignInFormFields.password: password,
    };
  }

  @override
  List<Object> get props => [
        email,
        password,
      ];
}
