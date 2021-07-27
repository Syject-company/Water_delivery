import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/extensions/text_style.dart';

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
const TextStyle _datePickerTextStyle = TextStyle(
  fontSize: _fontSize,
  fontWeight: FontWeight.w600,
);

class WaterFormDatePicker extends StatefulWidget {
  const WaterFormDatePicker({
    Key? key,
    this.validator,
    this.initialValue,
    this.hintText,
  }) : super(key: key);

  final FormFieldValidator<String>? validator;
  final String? initialValue;
  final String? hintText;

  @override
  WaterFormDatePickerState createState() => WaterFormDatePickerState();
}

class WaterFormDatePickerState extends State<WaterFormDatePicker>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  String get value => _textController.text;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

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

        final dateOfBirth = await _showDatePicker();
        if (dateOfBirth == null) {
          return;
        }

        _textController.text = DateFormat.yMMMMd().format(dateOfBirth);
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
          fontWeight: FontWeight.w600,
          color: AppColors.errorText,
        ).poppins,
        errorMaxLines: _errorMaxLines,
      ),
      autovalidateMode: AutovalidateMode.disabled,
      enableInteractiveSelection: false,
    );
  }

  Future<DateTime?> _showDatePicker() async {
    final initialDate = widget.initialValue != null
        ? DateTime.parse(widget.initialValue!)
        : DateTime.now();

    return showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: 'Select birthday date'.toUpperCase(),
      cancelText: 'Cancel'.toUpperCase(),
      confirmText: 'Ok'.toUpperCase(),
      builder: (_, child) {
        return Theme(
          data: ThemeData(
            primaryIconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            dialogBackgroundColor: Colors.white,
            dialogTheme: DialogTheme(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(_borderRadius),
              ),
            ),
            textTheme: TextTheme(
              // help style
              overline: _datePickerTextStyle.poppins,
              // title style
              headline4: const TextStyle(
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
                primary: AppColors.primary,
                splashFactory: NoSplash.splashFactory,
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
