import 'package:water/ui/validators/validator.dart';

final _emailPattern = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

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
    final errorText = StringBuffer();

    if (email != null) {
      if (required && email.isEmpty) {
        errorText.write('• Email can not be empty\n');
      } else if (minLength != null && email.length < minLength!) {
        errorText
            .write('• Length must be greater or equals $minLength chars\n');
      } else if (maxLength != null && email.length > maxLength!) {
        errorText.write('• Length must be less or equals $maxLength chars\n');
      }

      if (!_emailPattern.hasMatch(email)) {
        errorText.write('• Invalid email address');
      }
    }

    return errorText.isNotEmpty ? errorText.toString().trim() : null;
  }

  @override
  String? Function(String?) get validator => _validator;
}
