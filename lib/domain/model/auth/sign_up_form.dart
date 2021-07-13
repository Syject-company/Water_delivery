import 'package:equatable/equatable.dart';

class SignUpFormFields {
  static const String email = 'email';
  static const String password = 'password';
  static const String phoneNumber = 'phoneNumber';
}

class SignUpForm extends Equatable {
  SignUpForm({
    required this.email,
    required this.password,
    required this.phoneNumber,
  });

  final String email;
  final String password;
  final String phoneNumber;

  SignUpForm.fromJson(Map<String, dynamic> json)
      : this(
          email: json[SignUpFormFields.email] as String,
          password: json[SignUpFormFields.password] as String,
          phoneNumber: json[SignUpFormFields.phoneNumber] as String,
        );

  Map<String, dynamic> toJson() {
    return {
      SignUpFormFields.email: email,
      SignUpFormFields.password: password,
      SignUpFormFields.phoneNumber: phoneNumber,
    };
  }

  @override
  List<Object?> get props => [email, password, phoneNumber];
}
