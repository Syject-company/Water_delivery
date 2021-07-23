import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/shared_widgets/text/text.dart';

const double _elevation = 0.0;
const double _width = double.infinity;
const double _height = 58.0;
const double _borderRadius = 15.0;
const double _textSize = 17.0;
const double _textLineHeight = 1.25;

class WaterButton extends StatelessWidget {
  const WaterButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.backgroundColor = AppColors.primary,
    this.foregroundColor = AppColors.white,
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
        minimumSize: const Size(_width, _height),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
      ),
      child: WaterText(
        text,
        color: foregroundColor,
        fontSize: _textSize,
        lineHeight: _textLineHeight,
      ),
    );
  }
}
