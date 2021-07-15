import 'package:water/ui/validators/validator.dart';

final _emailPattern = RegExp(r"^[\w\-\.]+@([\w]+\.)+[\w]{2,4}$");

class EmailValidator extends Validator {
  const EmailValidator({
    bool required = true,
    int? minLength,
    int? maxLength,
  }) : super(
          required: required,
          minLength: minLength,
          maxLength: maxLength,
        );

  String? _validator(String? email) {
    if (email != null) {
      if (required && email.isEmpty) {
        return 'The Email field is required';
      } else if (!_emailPattern.hasMatch(email)) {
        return 'Invalid email address';
      } else if (minLength != null && email.length < minLength!) {
        return 'Email must have at least $minLength characters';
      } else if (maxLength != null && email.length > maxLength!) {
        return 'Email must be less or equals $maxLength characters';
      }
    }
  }

  @override
  String? Function(String?) get validator => _validator;
}
