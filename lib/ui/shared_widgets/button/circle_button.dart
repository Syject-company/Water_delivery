import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';

const double _width = 60.0;
const double _height = 60.0;
const double _iconSize = 32.0;

class WaterSocialButton extends StatelessWidget {
  const WaterSocialButton({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.secondary,
          shape: BoxShape.circle,
        ),
        width: _width,
        height: _height,
        child: Center(
          child: Icon(
            icon,
            color: AppColors.white,
            size: _iconSize,
          ),
        ),
      ),
    );
  }
}
