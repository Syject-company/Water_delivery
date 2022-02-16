import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/subscriptions/subscriptions_bloc.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/utils/localization.dart';

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
        fontWeight: FontWeight.w800,
        color: AppColors.primaryText,
      ),
      leading: AppBarBackButton(
        onPressed: () {
          homeNavigator.pop();
        },
      ),
      actions: [
        AppBarWhatsappButton(),
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
        context.showLoader(state is SubscriptionsLoading ||
            state is SubscriptionsToggleStatusRequest ||
            state is SubscriptionsDeleteRequest);

        if (state is SubscriptionsError) {
          showWaterDialog(context, ErrorAlert());
        }
      },
      buildWhen: (_, state) {
        return state is SubscriptionsLoaded || state is SubscriptionsError;
      },
      builder: (_, state) {
        if (state is SubscriptionsLoaded) {
          if (state.subscriptions.isEmpty) {
            return _buildNoSubscriptionsText();
          }

          return SizedBox.expand(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SeparatedColumn(
                includeOuterSeparators: true,
                separator: defaultDivider,
                children: state.subscriptions.map((subscription) {
                  return SubscriptionListItem(
                    key: ValueKey(subscription),
                    subscription: subscription,
                    selected: subscription == state.selectedSubscription,
                  );
                }).toList(growable: false),
              ),
            ),
          );
        } else if (state is SubscriptionsError) {
          return _buildTryAgainButton();
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildNoSubscriptionsText() {
    return Center(
      child: WaterText(
        'text.no_subscriptions'.tr(),
        fontSize: 20.0,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w700,
        color: AppColors.secondaryText,
      ),
    ).withPaddingAll(24.0);
  }

  Widget _buildHintText() {
    return WaterText(
      'text.tap_and_hold'.tr(),
      fontSize: 18.0,
      textAlign: TextAlign.center,
      fontWeight: FontWeight.w700,
      color: AppColors.primaryText,
    ).withPaddingAll(24.0);
  }

  Widget _buildActionButtons() {
    return BlocBuilder<SubscriptionsBloc, SubscriptionsState>(
      builder: (_, state) {
        bool isActive = false;
        bool enabled = false;

        if (state is SubscriptionsLoaded &&
            state.selectedSubscription != null) {
          isActive = state.selectedSubscription?.isActive ?? false;
          enabled = true;

          return Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              border: Border(top: defaultBorder),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildToggleSubscriptionStatusButton(isActive, enabled),
                const SizedBox(height: 16.0),
                _buildDeleteSubscriptionButton(enabled),
              ],
            ),
          );
        } else if (state is SubscriptionsLoaded &&
            state.selectedSubscription == null &&
            state.subscriptions.isNotEmpty) {
          return _buildHintText();
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildToggleSubscriptionStatusButton(
    bool isActive,
    bool enabled,
  ) {
    return WaterButton(
      onPressed: () {
        context.subscriptions.add(
          ToggleSubscriptionStatus(
              language: Localization.loadLocale().languageCode),
        );
      },
      text: isActive
          ? 'button.stop_subscription'.tr()
          : 'button.resume_subscription'.tr(),
      enabled: enabled,
    );
  }

  Widget _buildDeleteSubscriptionButton(bool enabled) {
    return WaterSecondaryButton(
      onPressed: () {
        context.subscriptions.add(
          DeleteSubscription(language: Localization.loadLocale().languageCode),
        );
      },
      text: 'button.delete_subscription'.tr(),
      radialRadius: 3.0,
      enabled: enabled,
    );
  }

  Widget _buildTryAgainButton() {
    return Center(
      child: WaterButton(
        onPressed: () {
          context.subscriptions.add(
            LoadSubscriptions(language: Localization.loadLocale().languageCode),
          );
        },
        text: 'button.try_again'.tr(),
      ),
    ).withPaddingAll(24.0);
  }
}
