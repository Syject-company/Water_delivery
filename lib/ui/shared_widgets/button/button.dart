import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:water/ui/constants/colors.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.onPressed,
    required this.text,
    this.backgroundColor = AppColors.primaryColor,
    this.foregroundColor = Colors.white,
  }) : super(key: key);

  static const double _elevation = 0.0;
  static const double _width = double.infinity;
  static const double _height = 58.0;
  static const double _borderRadius = 15.0;
  static const double _textSize = 16.0;
  static const double _textLineHeight = 1.25;

  final VoidCallback onPressed;
  final String text;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        elevation: _elevation,
        padding: EdgeInsets.zero,
        minimumSize: Size(_width, _height),
        backgroundColor: backgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(_borderRadius)),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: foregroundColor,
            fontSize: _textSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        strutStyle: const StrutStyle(
          forceStrutHeight: true,
          height: _textLineHeight,
        ),
      ),
    );
  }
}
