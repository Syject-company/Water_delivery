import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';

const Size _size = Size(60.0, 60.0);

class RoundedButton extends StatelessWidget {
  const RoundedButton({
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
        padding: EdgeInsets.zero,
        minimumSize: _size,
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
