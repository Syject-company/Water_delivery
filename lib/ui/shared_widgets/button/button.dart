import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/shared_widgets/text/text.dart';

const double _width = double.infinity;
const double _height = 58.0;
const double _borderRadius = 15.0;
const double _textSize = 17.0;
const double _textLineHeight = 1.25;
const Duration _animationDuration = Duration(milliseconds: 125);

class WaterButton extends StatelessWidget {
  const WaterButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.backgroundColor = AppColors.primary,
    this.foregroundColor = AppColors.white,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String text;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: _animationDuration,
        curve: Curves.fastOutSlowIn,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_borderRadius),
          color: backgroundColor,
        ),
        width: _width,
        height: _height,
        child: Center(
          child: WaterText(
            text,
            color: foregroundColor,
            fontSize: _textSize,
            lineHeight: _textLineHeight,
          ),
        ),
      ),
    );
  }
}
