import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';

const Size _size = Size(60.0, 60.0);

class WaterRoundedButton extends StatelessWidget {
  const WaterRoundedButton({
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
        elevation: 0.0,
        minimumSize: _size,
        padding: EdgeInsets.zero,
        backgroundColor: AppColors.secondaryColor,
        shape: const CircleBorder(),
      ),
      child: Center(
        child: Icon(
          icon,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
