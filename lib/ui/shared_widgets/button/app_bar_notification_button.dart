import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/notifications/notifications_bloc.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/utils/notifications_util.dart';

const double _iconSize = 32.0;

class AppBarNotificationButton extends StatefulWidget {
  const AppBarNotificationButton({Key? key}) : super(key: key);

  @override
  State<AppBarNotificationButton> createState() =>
      _AppBarNotificationButtonState();
}

class _AppBarNotificationButtonState extends State<AppBarNotificationButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsBloc, NotificationsState>(
      buildWhen: (_, state) {
        return state.status == NotificationsStatus.loaded;
      },
      builder: (_, state) {
        return GestureDetector(
          onTap: () {
            homeNavigator.pushNamed(HomeRoutes.notifications);

            final notificationIds = state.notifications.map((notification) {
              return notification.id;
            }).toList(growable: false);

            NotificationsUtil.markAsRead(notificationIds);
            setState(() {});
          },
          child: Center(
            child: Stack(
              children: [
                _buildIcon(),
                _buildBadge(state),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildIcon() {
    return Icon(
      AppIcons.notification,
      color: AppColors.appBarIconColor,
      size: _iconSize,
    );
  }

  Widget _buildBadge(NotificationsState state) {
    int unreadNotificationsCount = 0;
    final readNotifications = NotificationsUtil.loadReadNotifications;
    if (readNotifications != null) {
      unreadNotificationsCount = state.notifications.where((notification) {
        return !readNotifications.contains(notification.id);
      }).length;
    }

    Widget badge = const SizedBox.shrink();
    if (state.status == NotificationsStatus.loaded &&
        unreadNotificationsCount > 0) {
      badge = _buildNotificationsCounter(unreadNotificationsCount);
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
  }

  Widget _buildNotificationsCounter(int count) {
    return Container(
      width: 14.0,
      height: 14.0,
      decoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: WaterText(
          '$count',
          maxLines: 1,
          fontSize: 8.0,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w700,
          color: AppColors.white,
        ).withPadding(1.0, 0.0, 1.0, 0.0),
      ),
    );
  }
}
