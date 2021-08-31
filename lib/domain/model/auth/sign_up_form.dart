import 'package:equatable/equatable.dart';

class SignUpFormFields {
  static const String email = 'email';
  static const String password = 'password';
}

class SignUpForm extends Equatable {
  SignUpForm({
    this.email,
    this.password,
  });

  final String? email;
  final String? password;

  Map<String, dynamic> toJson() => {
        SignUpFormFields.email: email,
        SignUpFormFields.password: password,
      };

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}
