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
    this.onTap,
    this.onEditingComplete,
    this.prefixIcon,
  }) : super(key: key);

  final bool readOnly;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final String? initialValue;
  final String? labelText;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final Widget? prefixIcon;

  @override
  FormInputState createState() => FormInputState();
}

class FormInputState extends State<FormInput> {
  final GlobalKey<FormFieldState<String>> _formInputKey = GlobalKey();
  final FocusNode _focusNode = FocusNode();

  late final bool _isPassword =
      widget.keyboardType == TextInputType.visiblePassword;

  late Color _prefixIconColor = _getActiveColor();

  String get value => _formInputKey.currentState!.value ?? '';

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() => _prefixIconColor = _getActiveColor());
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _formInputKey,
      focusNode: _focusNode,
      readOnly: widget.readOnly,
      validator: widget.validator,
      initialValue: widget.initialValue,
      keyboardType: widget.keyboardType,
      onTap: widget.onTap,
      onEditingComplete: widget.onEditingComplete,
      obscureText: _isPassword,
      enableSuggestions: !_isPassword,
      autocorrect: !_isPassword,
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
        disabledBorder: _defaultBorder,
        focusedBorder: _focusedBorder,
        focusedErrorBorder: _errorBorder,
        errorBorder: _errorBorder,
        prefixIcon: widget.prefixIcon != null
            ? IconTheme(
                data: IconThemeData(
                  color: _prefixIconColor,
                ),
                child: widget.prefixIcon!,
              )
            : null,
        hintText: widget.labelText,
        hintStyle: const TextStyle(
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
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.done,
    );
  }

  Color _getActiveColor() {
    if (_focusNode.hasFocus) {
      return AppColors.primary;
    }
    return AppColors.secondaryText;
  }
}
