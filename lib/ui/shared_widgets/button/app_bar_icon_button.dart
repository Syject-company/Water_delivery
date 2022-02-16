import 'package:flutter/material.dart';
import 'package:water/app_colors.dart';

class AppBarIconButton extends StatelessWidget {
  const AppBarIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.iconSize = 32.0,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback onPressed;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Center(
        child: Icon(
          icon,
          color: AppColors.appBarIconColor,
          size: iconSize,
        ),
      ),
    );
  }
}
