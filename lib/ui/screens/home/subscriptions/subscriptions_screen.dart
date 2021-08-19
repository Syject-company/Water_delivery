import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/subscriptions/subscriptions_bloc.dart';
import 'package:water/domain/model/home/subscription/subscription.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/extensions/navigator.dart';
import 'package:water/ui/extensions/widget.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/separated_column.dart';

import 'widgets/subscription_list_item.dart';

class SubscriptionsScreen extends StatefulWidget {
  const SubscriptionsScreen({Key? key}) : super(key: key);

  @override
  _SubscriptionsScreenState createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  // Subscription? _selectedSubscription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: _buildSubscriptionItems(),
      ),
      bottomNavigationBar: _buildActionButtons(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return WaterAppBar(
      title: WaterText(
        'screen.subscriptions'.tr(),
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

  Widget _buildSubscriptionItems() {
    return BlocBuilder<SubscriptionsBloc, SubscriptionsState>(
      builder: (context, state) {
        if (state is SubscriptionsLoaded) {
          return SeparatedColumn(
            children: state.subscriptions.map(
              (subscription) {
                return SubscriptionListItem(
                  key: ValueKey(subscription),
                  subscription: subscription,
                  selected: state.selectedSubscription == subscription,
                );
              },
            ).toList(),
            includeOuterSeparators: true,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildActionButtons() {
    return BlocBuilder<SubscriptionsBloc, SubscriptionsState>(
      builder: (context, state) {
        final enabled = (state is SubscriptionsLoaded &&
            state.selectedSubscription != null);

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildStopSubscriptionButton(enabled),
            const SizedBox(height: 16.0),
            _buildDeleteSubscriptionButton(enabled),
          ],
        );
      },
    ).withPaddingAll(24.0);
  }

  Widget _buildStopSubscriptionButton(bool enabled) {
    return WaterButton(
      onPressed: () {},
      text: 'button.stop_subscription'.tr(),
      backgroundColor: AppColors.secondary,
      foregroundColor: AppColors.primary,
      enabled: enabled,
    );
  }

  Widget _buildDeleteSubscriptionButton(bool enabled) {
    return WaterButton(
      onPressed: () {},
      text: 'button.delete_subscription'.tr(),
      backgroundColor: AppColors.errorSecondary,
      foregroundColor: AppColors.white,
      enabled: enabled,
    );
  }
}
