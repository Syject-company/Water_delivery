import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/extensions/text_style.dart';
import 'package:water/ui/shared_widgets/text/text.dart';

const int _errorMaxLines = 3;
const double _fontSize = 15.0;
const double _lineHeight = 1.5;
const double _hintFontSize = 15.0;
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

class WaterFormInput extends StatefulWidget {
  const WaterFormInput({
    Key? key,
    this.controller,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.initialValue,
    this.labelText,
    this.hintText,
    this.onTap,
    this.onEditingComplete,
    this.prefixIcon,
    this.maxLength,
  }) : super(key: key);

  final TextEditingController? controller;
  final bool readOnly;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final String? initialValue;
  final String? labelText;
  final String? hintText;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final Widget? prefixIcon;
  final int? maxLength;

  @override
  WaterFormInputState createState() => WaterFormInputState();
}

class WaterFormInputState extends State<WaterFormInput> {
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
    return widget.labelText != null
        ? _wrapWithLabel(_buildFormInput())
        : _buildFormInput();
  }

  Widget _buildFormInput() {
    return TextFormField(
      key: _formInputKey,
      focusNode: _focusNode,
      controller: widget.controller,
      readOnly: widget.readOnly,
      validator: widget.validator,
      initialValue: widget.initialValue,
      keyboardType: widget.keyboardType,
      inputFormatters: [
        if (widget.maxLength != null)
          LengthLimitingTextInputFormatter(widget.maxLength),
      ],
      onTap: () {
        if (widget.readOnly) {
          _focusNode.unfocus();
        }
        widget.onTap?.call();
      },
      onEditingComplete: widget.onEditingComplete,
      obscureText: _isPassword,
      enableSuggestions: !_isPassword,
      autocorrect: !_isPassword,
      cursorColor: AppColors.primary,
      style: const TextStyle(
        fontSize: _fontSize,
        fontWeight: FontWeight.w500,
        color: AppColors.primaryText,
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
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          height: _lineHeight,
          fontSize: _hintFontSize,
          fontWeight: FontWeight.w400,
          color: AppColors.secondaryText,
        ).poppins,
        errorStyle: const TextStyle(
          height: _lineHeight,
          fontSize: _errorFontSize,
          fontWeight: FontWeight.w500,
          color: AppColors.errorText,
        ).poppins,
        errorMaxLines: _errorMaxLines,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.done,
      enableInteractiveSelection: !widget.readOnly,
    );
  }

  Widget _wrapWithLabel(Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 8.0),
          child: WaterText(
            widget.labelText!,
            maxLines: 1,
            lineHeight: 1.25,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        child,
      ],
    );
  }

  Color _getActiveColor() {
    if (_focusNode.hasFocus) {
      return AppColors.primary;
    }
    return AppColors.secondaryText;
  }
}
