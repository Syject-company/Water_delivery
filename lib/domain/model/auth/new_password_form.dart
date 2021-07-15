import 'package:equatable/equatable.dart';

class NewPasswordFormFields {
  static const String email = 'email';
  static const String resetCode = 'resetCode';
  static const String newPassword = 'newPassword';
}

class NewPasswordForm extends Equatable {
  NewPasswordForm({
    required this.email,
    required this.resetCode,
    required this.newPassword,
  });

  final String email;
  final String resetCode;
  final String newPassword;

  NewPasswordForm.fromJson(Map<String, dynamic> json)
      : this(
          email: json[NewPasswordFormFields.email] as String,
          resetCode: json[NewPasswordFormFields.resetCode] as String,
          newPassword: json[NewPasswordFormFields.newPassword] as String,
        );

  Map<String, dynamic> toJson() => {
        NewPasswordFormFields.email: email,
        NewPasswordFormFields.resetCode: resetCode,
        NewPasswordFormFields.newPassword: newPassword,
      };

  @override
  List<Object?> get props => [email, resetCode, newPassword];
}
