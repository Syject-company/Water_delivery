import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:water/ui/constants/colors.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.onPressed,
    required this.iconPath,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          elevation: 0.0,
          padding: EdgeInsets.zero,
          minimumSize: Size(60.0, 60.0),
          backgroundColor: AppColors.secondaryColor,
          shape: CircleBorder(),
        ),
        child: Center(
          child: SvgPicture.asset(
            iconPath,
            color: AppColors.primaryColor,
          ),
        ));
  }
}
