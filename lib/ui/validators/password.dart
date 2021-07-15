import 'package:water/ui/validators/validator.dart';

final passwordPattern = RegExp('^(?=.*[0-9])(?=.*[a-zA-Z]).{0,}\$');

class PasswordValidator extends Validator {
  const PasswordValidator({
    bool required = true,
    int minLength = 8,
    int maxLength = 24,
  }) : super(
          required: required,
          minLength: minLength,
          maxLength: maxLength,
        );

  String? _validator(String? password) {
    if (password != null) {
      if (required && password.isEmpty) {
        return 'The Password field is required';
      } else if (password.length < minLength!) {
        return 'Password must have at least $minLength characters';
      } else if (password.length > maxLength!) {
        return 'Password must be less or equals $maxLength characters';
      } else if (!passwordPattern.hasMatch(password)) {
        return 'Password must have at least 1 digit and character';
      }
    }
  }

  @override
  String? Function(String?) get validator => _validator;
}
