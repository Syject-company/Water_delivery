import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';

const double _elevation = 0.0;
const double _width = 60.0;
const double _height = 60.0;

class WaterCircleButton extends StatelessWidget {
  const WaterCircleButton({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        elevation: _elevation,
        minimumSize: const Size(_width, _height),
        padding: EdgeInsets.zero,
        backgroundColor: AppColors.secondary,
        shape: const CircleBorder(),
      ),
      child: Center(
        child: Icon(
          icon,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
