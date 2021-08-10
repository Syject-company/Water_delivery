import 'package:flutter/material.dart';

class MaskedInputController extends TextEditingController {
  MaskedInputController({
    String? text,
    required mask,
    required Map<String, RegExp> filter,
  })   : _mask = mask,
        _filter = filter,
        super(text: text) {
    addListener(_formatText);
    _formatText();
  }

  String _mask;
  Map<String, RegExp> _filter;

  @override
  set text(String newText) {
    value = value.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
      composing: TextRange.empty,
    );
  }

  bool isFilled() {
    return text.length == _mask.length;
  }

  void _formatText() {
    text = _applyMask();
  }

  String _applyMask() {
    final buffer = StringBuffer();

    var maskCharIndex = 0;
    var valueCharIndex = 0;

    while (true) {
      if (maskCharIndex == _mask.length) {
        break;
      }

      if (valueCharIndex == text.length) {
        break;
      }

      var maskChar = _mask[maskCharIndex];
      var valueChar = text[valueCharIndex];

      if (maskChar == valueChar) {
        buffer.write(maskChar);
        valueCharIndex += 1;
        maskCharIndex += 1;
        continue;
      }

      if (_filter.containsKey(maskChar)) {
        if (_filter[maskChar]!.hasMatch(valueChar)) {
          buffer.write(valueChar);
          maskCharIndex += 1;
        }

        valueCharIndex += 1;
        continue;
      }

      buffer.write(maskChar);
      maskCharIndex += 1;
      continue;
    }

    return buffer.toString();
  }
}
