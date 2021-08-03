import 'package:flutter/material.dart';
import 'package:water/bloc/home/navigation/navigation_bloc.dart';
import 'package:water/bloc/home/notification/notification_bloc.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/shared_widgets/text/text.dart';

const double _iconSize = 32.0;

class AppBarNotificationButton extends StatelessWidget {
  const AppBarNotificationButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.navigation.add(
          NavigateTo(screen: Screen.notifications),
        );
        onPressed?.call();
      },
      child: Center(
        child: Stack(
          children: <Widget>[
            _buildIcon(),
            PositionedDirectional(
              end: 0.0,
              bottom: 0.0,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 375),
                reverseDuration: const Duration(milliseconds: 375),
                switchInCurve: Curves.fastOutSlowIn,
                switchOutCurve: Curves.fastOutSlowIn,
                transitionBuilder: (child, animation) => ScaleTransition(
                  scale: animation,
                  child: child,
                ),
                child: context.notifications.state.items.isEmpty
                    ? const SizedBox.shrink()
                    : _buildBadge(context),
              ),
            ),
          ],
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

  Widget _buildBadge(BuildContext context) {
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
          '${context.notifications.state.items.length}',
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
