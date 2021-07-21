import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';

const Size _size = Size(45.0, 45.0);

class WaterIconButton extends StatelessWidget {
  const WaterIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.iconSize = 26.0,
    this.backgroundColor = AppColors.primaryColor,
    this.foregroundColor = Colors.white,
  }) : super(key: key);

  final VoidCallback onPressed;
  final IconData icon;
  final double iconSize;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        elevation: 0.0,
        minimumSize: _size,
        padding: EdgeInsets.zero,
        backgroundColor: backgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
      child: Icon(
        icon,
        color: foregroundColor,
        size: iconSize,
      ),
    );
  }
}
