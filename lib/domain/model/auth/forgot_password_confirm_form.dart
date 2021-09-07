import 'package:equatable/equatable.dart';

class ForgotPasswordConfirmFormFields {
  static const String email = 'email';
  static const String resetCode = 'resetCode';
  static const String newPassword = 'newPassword';
}

class ForgotPasswordConfirmForm extends Equatable {
  ForgotPasswordConfirmForm({
    required this.email,
    required this.resetCode,
    required this.newPassword,
  });

  final String email;
  final String resetCode;
  final String newPassword;

  Map<String, dynamic> toJson() {
    return {
      ForgotPasswordConfirmFormFields.email: email,
      ForgotPasswordConfirmFormFields.resetCode: resetCode,
      ForgotPasswordConfirmFormFields.newPassword: newPassword,
    };
  }

  @override
  List<Object> get props => [
        email,
        resetCode,
        newPassword,
      ];
}
