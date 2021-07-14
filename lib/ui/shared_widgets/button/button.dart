import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/shared_widgets/text/label.dart';

const double _elevation = 0.0;
const double _width = double.infinity;
const double _height = 58.0;
const double _borderRadius = 15.0;
const double _textSize = 16.0;
const double _textLineHeight = 1.25;

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.onPressed,
    required this.text,
    this.backgroundColor = AppColors.primaryColor,
    this.foregroundColor = Colors.white,
  }) : super(key: key);

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
          borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
        ),
      ),
      child: Label(
        text,
        color: foregroundColor,
        fontSize: _textSize,
        lineHeight: _textLineHeight,
      ),
    );
  }
}
