part of form_fields;

class WaterFormInput extends StatefulWidget {
  const WaterFormInput({
    Key? key,
    this.controller,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.textAlign = TextAlign.start,
    this.validator,
    this.formatters,
    this.initialValue,
    this.labelText,
    this.hintText,
    this.onTap,
    this.onEditingComplete,
    this.onChanged,
    this.prefixIcon,
    this.maxLength,
    this.maxLines = 1,
  }) : super(key: key);

  final TextEditingController? controller;
  final bool readOnly;
  final TextInputType keyboardType;
  final TextAlign textAlign;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? formatters;
  final String? initialValue;
  final String? labelText;
  final String? hintText;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final void Function(String)? onChanged;
  final Widget? prefixIcon;
  final int? maxLength;
  final int? maxLines;

  @override
  WaterFormInputState createState() => WaterFormInputState();
}

class WaterFormInputState extends State<WaterFormInput> {
  final GlobalKey<FormFieldState<String>> _formInputKey = GlobalKey();
  final FocusNode _focusNode = FocusNode();

  late final bool _isPassword =
      widget.keyboardType == TextInputType.visiblePassword;

  late Color _prefixIconColor = _getActiveColor();

  String? get value => _formInputKey.currentState!.value;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() => _prefixIconColor = _getActiveColor());
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.labelText != null
        ? _wrapWithLabel(_buildFormInput())
        : _buildFormInput();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Widget _buildFormInput() {
    return TextFormField(
      key: _formInputKey,
      focusNode: _focusNode,
      controller: widget.controller,
      readOnly: widget.readOnly,
      maxLines: widget.maxLines,
      validator: widget.validator,
      textAlign: widget.textAlign,
      initialValue: widget.initialValue,
      keyboardType: widget.keyboardType,
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(widget.maxLength),
        if (widget.formatters != null) ...widget.formatters!
      ],
      onTap: () {
        if (widget.readOnly) {
          _focusNode.unfocus();
        }
        widget.onTap?.call();
      },
      onEditingComplete: widget.onEditingComplete,
      onChanged: widget.onChanged,
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
          fontWeight: FontWeight.w500,
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
      enableInteractiveSelection: !widget.readOnly,
      textInputAction: TextInputAction.done,
    );
  }

  Widget _wrapWithLabel(Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 8.0),
          child: WaterText(
            widget.labelText!,
            maxLines: 1,
            fontSize: 15.0,
            lineHeight: 1.25,
            overflow: TextOverflow.fade,
            softWrap: false,
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
