import 'package:equatable/equatable.dart';

class SignUpFormFields {
  static const String email = 'email';
  static const String password = 'password';
}

class SignUpForm extends Equatable {
  SignUpForm({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  Map<String, dynamic> toJson() {
    return {
      SignUpFormFields.email: email,
      SignUpFormFields.password: password,
    };
  }

  @override
  List<Object> get props => [
        email,
        password,
      ];
}
