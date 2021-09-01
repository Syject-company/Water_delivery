part of form_fields;

const TextStyle _datePickerTextStyle = TextStyle(
  inherit: false,
  fontSize: _fontSize,
  fontWeight: FontWeight.w600,
);

class WaterFormDatePicker extends StatefulWidget {
  const WaterFormDatePicker({
    Key? key,
    required this.format,
    this.controller,
    this.validator,
    this.initialValue,
    this.hintText,
    this.helpText,
  }) : super(key: key);

  final DateFormat format;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final String? initialValue;
  final String? hintText;
  final String? helpText;

  @override
  WaterFormDatePickerState createState() => WaterFormDatePickerState();
}

class WaterFormDatePickerState extends State<WaterFormDatePicker>
    with SingleTickerProviderStateMixin {
  final FocusNode _focusNode = FocusNode();

  late final TextEditingController _textController =
      widget.controller ?? TextEditingController(text: widget.initialValue);

  DateTime? get value => _textController.text.isNotEmpty
      ? _format.parse(_textController.text)
      : null;

  DateFormat get _format => widget.format;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      focusNode: _focusNode,
      controller: _textController,
      validator: widget.validator,
      initialValue: widget.initialValue,
      onTap: () async {
        _focusNode.unfocus();

        final date = await _showDatePicker();

        if (date != null) {
          _textController.text = _format.format(date);
        }
      },
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
      autovalidateMode: AutovalidateMode.disabled,
      enableInteractiveSelection: false,
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Future<DateTime?> _showDatePicker() async {
    DateTime initialDate = DateTime.now();

    if (_textController.text.isNotEmpty) {
      initialDate = _format.parse(_textController.text);
    }

    return showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: widget.helpText?.toUpperCase(),
      cancelText: 'button.cancel'.tr().toUpperCase(),
      confirmText: 'button.ok'.tr().toUpperCase(),
      builder: (_, child) {
        return Theme(
          data: ThemeData(
            primaryIconTheme: IconThemeData(color: AppColors.black),
            backgroundColor: AppColors.white,
            dialogTheme: DialogTheme(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(_borderRadius),
              ),
            ),
            dialogBackgroundColor: AppColors.white,
            textTheme: TextTheme(
              // help style
              overline: _datePickerTextStyle.poppins,
              // title style
              headline4: const TextStyle(
                inherit: false,
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ).poppins,
              // years style
              bodyText1: _datePickerTextStyle.poppins,
              // month/year style
              subtitle2: _datePickerTextStyle.poppins,
              // days style
              caption: _datePickerTextStyle.poppins,
              // button style
              button: _datePickerTextStyle.poppins,
            ),
            colorScheme: ColorScheme(
              primary: AppColors.primary,
              primaryVariant: AppColors.primary,
              secondary: AppColors.primary,
              secondaryVariant: AppColors.primary,
              surface: AppColors.white,
              background: AppColors.white,
              onPrimary: AppColors.white,
              onSecondary: AppColors.primary,
              onSurface: AppColors.primaryText,
              onBackground: AppColors.white,
              onError: AppColors.errorText,
              error: AppColors.errorText,
              brightness: Brightness.dark,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
                primary: AppColors.primary,
              ),
            ),
            highlightColor: AppColors.transparent,
            splashFactory: NoSplash.splashFactory,
            platform: TargetPlatform.iOS,
          ),
          child: child!,
        );
      },
    );
  }
}
