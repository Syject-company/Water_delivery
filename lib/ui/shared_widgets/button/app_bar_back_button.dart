import 'dart:io';

import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';

const double _iconSize = 32.0;

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Center(
        child: Icon(
          _getPlatformIconData(),
          color: AppColors.primaryText,
          size: _iconSize,
        ),
      ),
    );
  }

  IconData? _getPlatformIconData() {
    if (Platform.isAndroid ||
        Platform.isFuchsia ||
        Platform.isLinux ||
        Platform.isWindows) {
      return Icons.arrow_back;
    } else if (Platform.isIOS || Platform.isMacOS) {
      return Icons.arrow_back_ios;
    }
  }
}
