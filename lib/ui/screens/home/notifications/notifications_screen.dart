import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:water/bloc/home/notifications/notifications_bloc.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';

import 'widgets/notification_list_item.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({Key? key}) : super(key: key);

  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return WaterAppBar(
      title: WaterText(
        'screen.notifications'.tr(),
        fontSize: 24.0,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w800,
        color: AppColors.primaryText,
      ),
      leading: AppBarBackButton(
        onPressed: () {
          homeNavigator.pop();
        },
      ),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<NotificationsBloc, NotificationsState>(
      listener: (_, state) {
        if (state.status == NotificationsStatus.loaded) {
          _refreshController.refreshCompleted();
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            SmartRefresher(
              controller: _refreshController,
              header: MaterialClassicHeader(
                backgroundColor: AppColors.white,
                color: AppColors.primary,
                distance: 30.0,
                height: 48.0,
              ),
              onRefresh: () {
                context.notifications.add(
                  LoadNotifications(),
                );
              },
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
                physics: const BouncingScrollPhysics(),
                itemCount: state.notifications.length,
                itemBuilder: (_, index) {
                  return NotificationListItem(
                    key: ValueKey(state.notifications[index]),
                    notification: state.notifications[index],
                  );
                },
                separatorBuilder: (_, __) {
                  return const SizedBox(height: 12.0);
                },
              ),
            ),
            if (state.notifications.isEmpty) _buildNoSubscriptionsText(),
          ],
        );
      },
    );
  }

  Widget _buildNoSubscriptionsText() {
    return Center(
      child: WaterText(
        'text.no_notifications'.tr(),
        fontSize: 20.0,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w700,
        color: AppColors.secondaryText,
      ),
    ).withPaddingAll(24.0);
  }
}
