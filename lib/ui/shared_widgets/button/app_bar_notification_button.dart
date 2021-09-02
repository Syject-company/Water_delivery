import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/notifications/notifications_bloc.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';

const double _iconSize = 32.0;

class AppBarNotificationButton extends StatelessWidget {
  const AppBarNotificationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        homeNavigator.pushNamed(HomeRoutes.notifications);
      },
      child: Center(
        child: Stack(
          children: [
            _buildIcon(),
            _buildBadge(),
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

  Widget _buildBadge() {
    return BlocBuilder<NotificationsBloc, NotificationsState>(
      builder: (context, state) {
        Widget badge = const SizedBox.shrink();
        if (state.status == NotificationsStatus.loaded &&
            state.notifications.isNotEmpty) {
          badge = _buildNotificationsCounter(state);
        }

        return PositionedDirectional(
          end: 0.0,
          bottom: 0.0,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 375),
            reverseDuration: const Duration(milliseconds: 375),
            switchInCurve: Curves.fastOutSlowIn,
            switchOutCurve: Curves.fastOutSlowIn,
            transitionBuilder: (child, animation) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            child: badge,
          ),
        );
      },
    );
  }

  Widget _buildNotificationsCounter(NotificationsState state) {
    final amount = state.notifications.length;

    return Container(
      width: 14.0,
      height: 14.0,
      decoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      child: WaterText(
        '$amount',
        maxLines: 1,
        fontSize: 9.0,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        color: AppColors.white,
      ).withPadding(1.0, 0.0, 1.0, 0.0),
    );
  }
}
