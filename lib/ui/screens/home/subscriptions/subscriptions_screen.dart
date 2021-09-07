import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/subscriptions/subscriptions_bloc.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildActionButtons(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
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

  Widget _buildBody() {
    return LoaderOverlay(
      child: _buildSubscriptionItems(),
    );
  }

  Widget _buildSubscriptionItems() {
    return BlocConsumer<SubscriptionsBloc, SubscriptionsState>(
      listener: (context, state) {
        context.showLoader(state is SubscriptionsLoading);
      },
      builder: (_, state) {
        if (state is SubscriptionsLoaded) {
          if (state.subscriptions.isEmpty) {
            return _buildNoSubscriptionsText();
          }

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SeparatedColumn(
              children: state.subscriptions.map((subscription) {
                return SubscriptionListItem(
                  key: ValueKey(subscription),
                  subscription: subscription,
                  selected: subscription == state.selectedSubscription,
                );
              }).toList(),
              includeOuterSeparators: true,
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildNoSubscriptionsText() {
    return Center(
      child: WaterText(
        'There are not subscriptions yet',
        fontSize: 20.0,
        color: AppColors.secondaryText,
      ),
    );
  }

  Widget _buildActionButtons() {
    return BlocBuilder<SubscriptionsBloc, SubscriptionsState>(
      builder: (_, state) {
        bool enableStopSubscription = false;
        bool enableDeleteSubscription = false;

        if (state is SubscriptionsLoaded) {
          final selectedSubscription = state.selectedSubscription;

          if (selectedSubscription != null) {
            enableStopSubscription = selectedSubscription.isActive;
            enableDeleteSubscription = true;
          }
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildStopSubscriptionButton(enableStopSubscription),
            const SizedBox(height: 16.0),
            _buildDeleteSubscriptionButton(enableDeleteSubscription),
          ],
        );
      },
    ).withPaddingAll(24.0);
  }

  Widget _buildStopSubscriptionButton(bool enabled) {
    return WaterButton(
      onPressed: () {
        context.subscriptions.add(StopSubscription());
      },
      text: 'button.stop_subscription'.tr(),
      backgroundColor: AppColors.secondary,
      foregroundColor: AppColors.primary,
      enabled: enabled,
    );
  }

  Widget _buildDeleteSubscriptionButton(bool enabled) {
    return WaterButton(
      onPressed: () {
        context.subscriptions.add(DeleteSubscription());
      },
      text: 'button.delete_subscription'.tr(),
      backgroundColor: AppColors.errorSecondary,
      foregroundColor: AppColors.white,
      enabled: enabled,
    );
  }
}
