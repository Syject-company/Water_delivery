import 'package:equatable/equatable.dart';

class ChangePasswordFormFields {
  static const String password = 'password';
  static const String newPassword = 'newPassword';
}

class ChangePasswordForm extends Equatable {
  const ChangePasswordForm({
    required this.password,
    required this.newPassword,
  });

  final String password;
  final String newPassword;

  Map<String, dynamic> toJson() {
    return {
      ChangePasswordFormFields.password: password,
      ChangePasswordFormFields.newPassword: newPassword,
    };
  }

  @override
  List<Object> get props => [
        password,
        newPassword,
      ];
}
