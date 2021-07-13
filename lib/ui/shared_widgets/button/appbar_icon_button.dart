import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';

class AppBarIconButton extends StatelessWidget {
  const AppBarIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.iconSize = 24.0,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback onPressed;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Icon(
          icon,
          color: AppColors.primaryTextColor,
          size: iconSize,
        ),
      ),
    );
  }
}
