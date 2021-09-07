import 'package:equatable/equatable.dart';

class ForgotPasswordInitialFormFields {
  static const String email = 'email';
}

class ForgotPasswordInitialForm extends Equatable {
  ForgotPasswordInitialForm({required this.email});

  final String email;

  Map<String, dynamic> toJson() {
    return {
      ForgotPasswordInitialFormFields.email: email,
    };
  }

  @override
  List<Object> get props => [email];
}
