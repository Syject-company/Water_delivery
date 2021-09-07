import 'package:water/ui/validators/validator.dart';

final passwordPattern = RegExp('^(?=.*[0-9])(?=.*[a-zA-Z]).{0,}\$');

class PasswordValidator extends Validator {
  const PasswordValidator({
    this.fieldName,
    bool required = true,
    int minLength = 6,
    int maxLength = 24,
  }) : super(
          required: required,
          minLength: minLength,
          maxLength: maxLength,
        );

  final String? fieldName;

  String? _validator(String? password) {
    if (password != null) {
      if (required && password.trim().isEmpty) {
        return 'The ${fieldName != null ? '$fieldName field' : 'Field'} is required';
      } else if (password.length < minLength!) {
        return '${fieldName ?? 'Field'} must have at least $minLength characters';
      } else if (password.length > maxLength!) {
        return '${fieldName ?? 'Field'} must be less or equals $maxLength characters';
      } else if (!passwordPattern.hasMatch(password)) {
        return '${fieldName ?? 'Field'} must have at least 1 digit and character';
      }
    }
  }

  @override
  String? Function(String?) get validator => _validator;
}
