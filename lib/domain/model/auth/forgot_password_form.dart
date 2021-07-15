import 'package:equatable/equatable.dart';

class ForgotPasswordFormFields {
  static const String email = 'email';
}

class ForgotPasswordForm extends Equatable {
  ForgotPasswordForm({
    required this.email,
  });

  final String email;

  ForgotPasswordForm.fromJson(Map<String, dynamic> json)
      : this(
          email: json[ForgotPasswordFormFields.email] as String,
        );

  Map<String, dynamic> toJson() => {
        ForgotPasswordFormFields.email: email,
      };

  @override
  List<Object?> get props => [email];
}
