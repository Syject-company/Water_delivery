import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/extensions/text_style.dart';

class FormInput extends StatefulWidget {
  const FormInput({
    Key? key,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.initialValue,
    this.labelText,
  }) : super(key: key);

  final bool readOnly;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final String? initialValue;
  final String? labelText;

  @override
  _FormInputState createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  static const int _errorMaxLines = 3;
  static const double _fontSize = 15.0;
  static const double _labelFontSize = 15.0;
  static const double _errorFontSize = 14.0;
  static const double _borderRadius = 19.0;
  static const double _borderWidth = 1.0;
  static const EdgeInsetsGeometry _contentPadding =
      const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0);
  static const OutlineInputBorder _defaultBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
    borderSide: BorderSide(
      color: AppColors.inputDefaultBorderColor,
      width: _borderWidth,
    ),
  );
  static const OutlineInputBorder _focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
    borderSide: BorderSide(
      color: AppColors.inputFocusedBorderColor,
      width: _borderWidth,
    ),
  );
  static const OutlineInputBorder _errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
    borderSide: BorderSide(
      color: AppColors.inputErrorBorderColor,
      width: _borderWidth,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final isPassword = widget.keyboardType == TextInputType.visiblePassword;

    return TextFormField(
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      readOnly: widget.readOnly,
      validator: widget.validator,
      initialValue: widget.initialValue,
      keyboardType: widget.keyboardType,
      obscureText: isPassword,
      enableSuggestions: !isPassword,
      autocorrect: !isPassword,
      cursorColor: AppColors.primaryColor,
      style: const TextStyle(
        color: AppColors.primaryTextColor,
        fontSize: _fontSize,
        fontWeight: FontWeight.w500,
      ).poppins,
      decoration: InputDecoration(
        contentPadding: _contentPadding,
        enabledBorder: _defaultBorder,
        focusedBorder: _focusedBorder,
        focusedErrorBorder: _errorBorder,
        errorBorder: _errorBorder,
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          color: AppColors.secondaryTextColor,
          fontSize: _labelFontSize,
          fontWeight: FontWeight.w500,
        ).poppins,
        errorStyle: const TextStyle(
          color: AppColors.errorTextColor,
          fontSize: _errorFontSize,
          fontWeight: FontWeight.w600,
        ).poppins,
        errorMaxLines: _errorMaxLines,
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    );
  }
}
