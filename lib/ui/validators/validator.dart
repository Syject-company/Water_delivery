abstract class Validator {
  const Validator({
    required this.required,
    this.minLength,
    this.maxLength,
  });

  final bool required;
  final int? minLength;
  final int? maxLength;

  String? Function(String?) get validator;
}
