import 'package:flutter/material.dart';
import 'package:water/ui/shared_widgets/water.dart';

const double _width = double.infinity;
const double _height = 58.0;
const double _borderRadius = 15.0;
const double _fontSize = 18.0;
const double _textLineHeight = 1.35;

class WaterSecondaryButton extends StatelessWidget {
  const WaterSecondaryButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.fontSize,
    this.radialRadius = 1.0,
    this.enabled = true,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String text;
  final double? fontSize;
  final double radialRadius;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onPressed : null,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_borderRadius),
          gradient: enabled
              ? RadialGradient(
                  colors: [
                    AppColors.white,
                    AppColors.grey,
                  ],
                  stops: [
                    0.0,
                    1.0,
                  ],
                  radius: radialRadius,
                )
              : null,
          color: enabled ? null : AppColors.disabled,
        ),
        width: _width,
        height: _height,
        child: Center(
          child: WaterText(
            text,
            fontSize: fontSize ?? _fontSize,
            lineHeight: _textLineHeight,
            fontWeight: FontWeight.w700,
            color: enabled ? AppColors.primaryText : AppColors.white,
          ),
        ),
      ),
    );
  }
}
