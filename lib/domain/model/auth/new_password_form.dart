import 'package:equatable/equatable.dart';

class NewPasswordFormFields {
  static const String email = 'email';
  static const String resetCode = 'resetCode';
  static const String newPassword = 'newPassword';
}

class NewPasswordForm extends Equatable {
  NewPasswordForm({
    this.email,
    this.resetCode,
    this.newPassword,
  });

  final String? email;
  final String? resetCode;
  final String? newPassword;

  Map<String, dynamic> toJson() => {
        NewPasswordFormFields.email: email,
        NewPasswordFormFields.resetCode: resetCode,
        NewPasswordFormFields.newPassword: newPassword,
      };

  @override
  List<Object?> get props => [
        email,
        resetCode,
        newPassword,
      ];
}
