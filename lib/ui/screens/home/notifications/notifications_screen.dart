import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/bloc/home/notification/notification_bloc.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';

import 'widgets/notification_list_item.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifications = context.notifications.state.items;

    return Scaffold(
      appBar: _buildAppBar(context),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
        physics: const BouncingScrollPhysics(),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return NotificationListItem(
            key: ValueKey(notifications[index]),
            notification: notifications[index],
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 12.0);
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return WaterAppBar(
      title: WaterText(
        'screen.notifications'.tr(),
        fontSize: 24.0,
        textAlign: TextAlign.center,
      ),
      leading: AppBarBackButton(
        onPressed: () => homeNavigator.pop(),
      ),
    );
  }
}
