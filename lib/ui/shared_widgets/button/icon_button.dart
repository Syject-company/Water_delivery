import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';

const double _width = 45.0;
const double _height = 45.0;
const double _borderRadius = 10.0;
const double _iconSize = 21.0;

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
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            borderRadius ?? _borderRadius,
          ),
          color: backgroundColor,
        ),
        width: width ?? _width,
        height: height ?? _height,
        child: Center(
          child: Icon(
            icon,
            color: foregroundColor,
            size: iconSize ?? _iconSize,
          ),
        ),
      ),
    );
  }
}
