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

  SignInForm.fromJson(Map<String, dynamic> json)
      : this(
          email: json[SignInFormFields.email] as String,
          password: json[SignInFormFields.password] as String,
        );

  Map<String, dynamic> toJson() => {
        SignInFormFields.email: email,
        SignInFormFields.password: password,
      };

  @override
  List<Object?> get props => [email, password];
}
