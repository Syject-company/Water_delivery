import 'package:water/ui/validators/validator.dart';

class PasswordValidator extends Validator {
  const PasswordValidator({this.minLength, this.maxLength});

  final int? minLength;
  final int? maxLength;

  String? _validator(String? password) {
    final errorText = StringBuffer();

    if (password != null) {
      if (password.isEmpty) {
        errorText.write('• Password can not be empty\n');
      } else if (minLength != null && password.length < minLength!) {
        errorText
            .write('• Length must be greater or equals $minLength chars\n');
      } else if (maxLength != null && password.length > maxLength!) {
        errorText.write('• Length must be less or equals $maxLength chars\n');
      }
    }

    return errorText.isNotEmpty ? errorText.toString().trim() : null;
  }

  @override
  String? Function(String?) get validator => _validator;
}
