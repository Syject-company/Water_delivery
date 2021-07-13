import 'dart:io';

import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  static const double _iconSize = 24.0;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      child: Icon(
        _getPlatformIconData(),
        color: AppColors.primaryTextColor,
        size: _iconSize,
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
      return Icons.arrow_back_ios_new;
    }
  }
}
