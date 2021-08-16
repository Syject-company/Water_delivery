import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/subscriptions/subscriptions_bloc.dart';
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
  String? _selectedSubscription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: _buildSubscriptionItems(context),
      ),
      bottomNavigationBar: _buildActionButtons(),
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

  Widget _buildSubscriptionItems(BuildContext context) {
    return BlocBuilder<SubscriptionsBloc, SubscriptionsState>(
      builder: (context, state) {
        if (state is SubscriptionsLoaded) {
          return SeparatedColumn(
            children: state.subscriptions
                .map(
                  (subscription) => SubscriptionListItem(
                    key: ValueKey(subscription),
                    subscription: subscription,
                  ),
                )
                .toList(),
            includeOuterSeparators: true,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  void onItemSelected(String s) {
    setState(() => _selectedSubscription = s);
  }

  void onItemUnSelected() {
    setState(() => _selectedSubscription = null);
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
      enabled: _selectedSubscription != null,
    );
  }

  Widget _buildDeleteSubscriptionButton() {
    return WaterButton(
      onPressed: () {},
      text: 'Delete Subscription',
      backgroundColor: AppColors.errorSecondary,
      foregroundColor: AppColors.white,
      enabled: _selectedSubscription != null,
    );
  }
}
