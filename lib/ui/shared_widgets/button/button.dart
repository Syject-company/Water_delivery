import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/shared_widgets/water.dart';

const double _width = double.infinity;
const double _height = 58.0;
const double _borderRadius = 15.0;
const double _fontSize = 17.0;
const double _textLineHeight = 1.35;

class WaterButton extends StatelessWidget {
  const WaterButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.enabled = true,
    this.backgroundColor = AppColors.primary,
    this.foregroundColor = AppColors.white,
    this.fontSize,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String text;
  final bool enabled;
  final Color backgroundColor;
  final Color foregroundColor;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onPressed : null,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_borderRadius),
          color: enabled ? backgroundColor : AppColors.disabled,
        ),
        width: _width,
        height: _height,
        child: Center(
          child: WaterText(
            text,
            color: enabled ? foregroundColor : AppColors.white,
            fontSize: fontSize ?? _fontSize,
            lineHeight: _textLineHeight,
          ),
        ),
      ),
    );
  }
}
