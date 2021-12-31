import 'package:flutter/services.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  final RegExp _twoOrMoreDots = RegExp(r'(\..*){2,}');
  final RegExp _fractionDigitLimit = RegExp(r'\.([0-9]){3,}$');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text.replaceAll(',', '.');

    if (newText.startsWith('.') ||
        _twoOrMoreDots.hasMatch(newText) ||
        _fractionDigitLimit.hasMatch(newText)) {
      return oldValue;
    }

    return newValue.copyWith(text: newText);
  }
}
