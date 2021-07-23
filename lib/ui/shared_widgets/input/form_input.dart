import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/extensions/text_style.dart';

const int _errorMaxLines = 3;
const double _fontSize = 15.0;
const double _lineHeight = 1.5;
const double _labelFontSize = 15.0;
const double _errorFontSize = 14.0;
const double _borderRadius = 19.0;
const double _borderWidth = 1.0;
const EdgeInsetsGeometry _contentPadding =
    EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0);
const OutlineInputBorder _defaultBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
  borderSide: BorderSide(
    color: AppColors.inputDefaultBorder,
    width: _borderWidth,
  ),
);
const OutlineInputBorder _focusedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
  borderSide: BorderSide(
    color: AppColors.inputFocusedBorder,
    width: _borderWidth,
  ),
);
const OutlineInputBorder _errorBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
  borderSide: BorderSide(
    color: AppColors.inputErrorBorder,
    width: _borderWidth,
  ),
);

class FormInput extends StatefulWidget {
  const FormInput({
    Key? key,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.initialValue,
    this.labelText,
    this.onEditingComplete,
  }) : super(key: key);

  final bool readOnly;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final String? initialValue;
  final String? labelText;
  final VoidCallback? onEditingComplete;

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
      readOnly: widget.readOnly,
      validator: widget.validator,
      initialValue: widget.initialValue,
      keyboardType: widget.keyboardType,
      onEditingComplete: widget.onEditingComplete,
      obscureText: isPassword,
      enableSuggestions: !isPassword,
      autocorrect: !isPassword,
      cursorColor: AppColors.primary,
      style: const TextStyle(
        color: AppColors.primaryText,
        fontSize: _fontSize,
        fontWeight: FontWeight.w500,
      ).poppins,
      strutStyle: const StrutStyle(
        forceStrutHeight: true,
        height: _lineHeight,
      ),
      decoration: InputDecoration(
        contentPadding: _contentPadding,
        enabledBorder: _defaultBorder,
        focusedBorder: _focusedBorder,
        focusedErrorBorder: _errorBorder,
        errorBorder: _errorBorder,
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          color: AppColors.secondaryText,
          fontSize: _labelFontSize,
          fontWeight: FontWeight.w500,
        ).poppins,
        errorStyle: const TextStyle(
          color: AppColors.errorText,
          fontSize: _errorFontSize,
          fontWeight: FontWeight.w600,
        ).poppins,
        errorMaxLines: _errorMaxLines,
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.done,
    );
  }

  String get value => _formInputKey.currentState!.value ?? '';

  String get errorText => _formInputKey.currentState!.errorText ?? '';
}
