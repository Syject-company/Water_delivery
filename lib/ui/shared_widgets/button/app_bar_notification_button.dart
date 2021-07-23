import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/shared_widgets/text/text.dart';

const double _iconSize = 32.0;
const EdgeInsetsGeometry _margin = const EdgeInsets.only(right: 16.0);

class AppBarNotificationButton extends StatelessWidget {
  const AppBarNotificationButton({
    Key? key,
    required this.onPressed,
    this.notificationsCount,
  }) : super(key: key);

  final VoidCallback onPressed;
  final int? notificationsCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: _margin,
      child: GestureDetector(
        onTap: onPressed,
        child: Center(
          child: Stack(
            children: [
              _buildIcon(),
              Positioned(
                right: 0.0,
                bottom: 0.0,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 375),
                  reverseDuration: const Duration(milliseconds: 375),
                  switchInCurve: Curves.easeInOutCubic,
                  switchOutCurve: Curves.easeInOutCubic,
                  transitionBuilder: (child, animation) => ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
                  child: notificationsCount == null
                      ? const SizedBox.shrink()
                      : _buildBadge(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Icon(
      AppIcons.notification,
      color: AppColors.primaryText,
      size: _iconSize,
    );
  }

  Widget _buildBadge() {
    return Container(
      width: 14.0,
      height: 14.0,
      decoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.0),
        child: WaterText(
          '$notificationsCount',
          maxLines: 1,
          fontSize: 9.0,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          color: AppColors.white,
        ),
      ),
    );
  }
}
