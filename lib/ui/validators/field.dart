import 'package:water/ui/validators/validator.dart';

class FieldValidator extends Validator {
  const FieldValidator({
    this.fieldName,
    bool required = true,
    int? minLength,
    int? maxLength,
  }) : super(
          required: required,
          minLength: minLength,
          maxLength: maxLength,
        );

  final String? fieldName;

  String? _validator(String? text) {
    if (text != null) {
      if (required && text.isEmpty) {
        return 'The ${fieldName != null ? '$fieldName field' : 'Field'} is required';
      } else if (minLength != null && text.length < minLength!) {
        return '${fieldName ?? 'Field'} must have at least $minLength characters';
      } else if (maxLength != null && text.length > maxLength!) {
        return '${fieldName ?? 'Field'} must be less or equals $maxLength characters';
      }
    }
  }

  @override
  String? Function(String?) get validator => _validator;
}
