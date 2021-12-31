import 'package:flutter/material.dart';
import 'package:water/app_colors.dart';

const double _width = 45.0;
const double _height = 45.0;
const double _borderRadius = 10.0;
const double _iconSize = 21.0;

class WaterIconButton extends StatelessWidget {
  const WaterIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.width,
    this.height,
    this.borderRadius,
    this.iconSize,
  }) : super(key: key);

  final VoidCallback onPressed;
  final IconData icon;
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
          borderRadius: BorderRadius.circular(borderRadius ?? _borderRadius),
          gradient: RadialGradient(
            colors: [
              AppColors.white,
              AppColors.grey,
            ],
            stops: [
              0.0,
              1.0,
            ],
            radius: 0.75,
          ),
        ),
        width: width ?? _width,
        height: height ?? _height,
        child: Center(
          child: Icon(
            icon,
            color: AppColors.primaryText,
            size: iconSize ?? _iconSize,
          ),
        ),
      ),
    );
  }
}
