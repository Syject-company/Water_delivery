import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/extensions/text_style.dart';

const int _errorMaxLines = 3;
const double _fontSize = 15.0;
const double _labelFontSize = 15.0;
const double _errorFontSize = 14.0;
const double _borderRadius = 19.0;
const double _borderWidth = 1.0;
const EdgeInsetsGeometry _contentPadding =
    EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0);
const OutlineInputBorder _defaultBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
  borderSide: BorderSide(
    color: AppColors.inputDefaultBorderColor,
    width: _borderWidth,
  ),
);
const OutlineInputBorder _focusedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
  borderSide: BorderSide(
    color: AppColors.inputFocusedBorderColor,
    width: _borderWidth,
  ),
);
const OutlineInputBorder _errorBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
  borderSide: BorderSide(
    color: AppColors.inputErrorBorderColor,
    width: _borderWidth,
  ),
);

class FormInput extends StatefulWidget {
  const FormInput({
    Key? key,
    this.onEditingComplete,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.initialValue,
    this.labelText,
  }) : super(key: key);

  final VoidCallback? onEditingComplete;
  final bool readOnly;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final String? initialValue;
  final String? labelText;

  @override
  FormInputState createState() => FormInputState();
}

class FormInputState extends State<FormInput> {
  final GlobalKey<FormFieldState<String>> _formInputKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final isPassword = widget.keyboardType == TextInputType.visiblePassword;

    return TextFormField(
      key: _formInputKey,
      onEditingComplete: widget.onEditingComplete,
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  String get value => _formInputKey.currentState!.value ?? '';

  String get errorText => _formInputKey.currentState!.errorText ?? '';
}
