import 'package:equatable/equatable.dart';

class ForgotPasswordFormFields {
  static const String email = 'email';
}

class ForgotPasswordForm extends Equatable {
  ForgotPasswordForm({this.email});

  final String? email;

  Map<String, dynamic> toJson() {
    return {
      ForgotPasswordFormFields.email: email,
    };
  }

  @override
  List<Object?> get props => [email];
}
