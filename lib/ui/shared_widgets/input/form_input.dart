import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:water/ui/constants/colors.dart';

class FormInput extends StatefulWidget {
  const FormInput({
    Key? key,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.initialValue,
    this.labelText,
  }) : super(key: key);

  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final String? initialValue;
  final String? labelText;

  @override
  _FormInputState createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  static const double _fontSize = 15.0;
  static const double _labelFontSize = 15.0;
  static const double _errorFontSize = 14.0;
  static const double _borderRadius = 19.0;
  static const double _borderWidth = 1.0;
  static const EdgeInsetsGeometry _contentPadding =
      const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0);

  final OutlineInputBorder _defaultBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
    borderSide: BorderSide(
      color: AppColors.inputDefaultBorderColor,
      width: _borderWidth,
    ),
  );
  final OutlineInputBorder _focusedBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
    borderSide: BorderSide(
      color: AppColors.inputFocusedBorderColor,
      width: _borderWidth,
    ),
  );
  final OutlineInputBorder _errorBorder = const OutlineInputBorder(
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      initialValue: widget.initialValue,
      keyboardType: widget.keyboardType,
      obscureText: isPassword,
      enableSuggestions: !isPassword,
      autocorrect: !isPassword,
      cursorColor: AppColors.primaryColor,
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(
          color: AppColors.primaryTextColor,
          fontSize: _fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
      decoration: InputDecoration(
        contentPadding: _contentPadding,
        enabledBorder: _defaultBorder,
        focusedBorder: _focusedBorder,
        focusedErrorBorder: _errorBorder,
        errorBorder: _errorBorder,
        labelText: widget.labelText,
        labelStyle: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: AppColors.secondaryTextColor,
            fontSize: _labelFontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
        errorText: null,
        errorStyle: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: AppColors.errorTextColor,
            fontSize: _errorFontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    );
  }
}
