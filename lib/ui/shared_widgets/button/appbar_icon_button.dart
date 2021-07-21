import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';

class AppBarIconButton extends StatelessWidget {
  const AppBarIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.margin = const EdgeInsets.only(right: 16.0),
    this.iconSize = 32.0,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry margin;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: GestureDetector(
        onTap: onPressed,
        child: Center(
          child: Icon(
            icon,
            color: AppColors.primaryTextColor,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}
