import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/extensions/navigator.dart';
import 'package:water/ui/extensions/widget.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/separated_column.dart';

import 'widgets/subscription_list_item.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: _buildOrderItems(context),
      ),
      bottomNavigationBar: _buildActionButtons(),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildStopSubscriptionButton(),
        const SizedBox(height: 16.0),
        _buildDeleteSubscriptionButton(),
      ],
    ).withPaddingAll(24.0);
  }

  Widget _buildStopSubscriptionButton() {
    return WaterButton(
      onPressed: () {},
      text: 'Stop Subscription',
      backgroundColor: AppColors.secondary,
      foregroundColor: AppColors.primary,
    );
  }

  Widget _buildDeleteSubscriptionButton() {
    return WaterButton(
      onPressed: () {},
      text: 'Delete Subscription',
      backgroundColor: AppColors.errorSecondary,
      foregroundColor: AppColors.white,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return WaterAppBar(
      title: WaterText(
        'Subscriptions',
        fontSize: 24.0,
        textAlign: TextAlign.center,
      ),
      leading: AppBarBackButton(
        onPressed: () {
          homeNavigator.pop();
        },
      ),
      actions: [
        AppBarIconButton(
          onPressed: () {},
          icon: AppIcons.whatsapp,
        ),
        AppBarNotificationButton(),
      ],
    );
  }

  Widget _buildOrderItems(BuildContext context) {
    return SeparatedColumn(
      children: [
        SubscriptionListItem(),
        SubscriptionListItem(),
        SubscriptionListItem(),
      ],
      separator: const Divider(
        height: 1.0,
        thickness: 1.0,
        color: AppColors.borderColor,
      ),
      includeOuterSeparators: true,
    );
  }
}
