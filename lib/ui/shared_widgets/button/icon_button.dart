import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';

const double _elevation = 0.0;
const double _defaultWidth = 45.0;
const double _defaultHeight = 45.0;
const double _defaultBorderRadius = 10.0;
const double _defaultIconSize = 21.0;

class WaterIconButton extends StatelessWidget {
  const WaterIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.backgroundColor = AppColors.primary,
    this.foregroundColor = AppColors.white,
    this.width,
    this.height,
    this.borderRadius,
    this.iconSize,
  }) : super(key: key);

  final VoidCallback onPressed;
  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? _defaultWidth,
      height: height ?? _defaultHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          elevation: _elevation,
          padding: EdgeInsets.zero,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              borderRadius ?? _defaultBorderRadius,
            ),
          ),
        ),
        child: Icon(
          icon,
          color: foregroundColor,
          size: iconSize ?? _defaultIconSize,
        ),
      ),
    );
  }
}
