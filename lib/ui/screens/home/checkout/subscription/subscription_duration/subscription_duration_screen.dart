import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/checkout/subscription/subscription_bloc.dart';
import 'package:water/ui/screens/home/checkout/subscription/subscription_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';

import 'widgets/subscription_duration_picker.dart';

class SubscriptionDurationScreen extends StatefulWidget {
  SubscriptionDurationScreen({Key? key}) : super(key: key);

  @override
  _SubscriptionDurationScreenState createState() =>
      _SubscriptionDurationScreenState();
}

class _SubscriptionDurationScreenState
    extends State<SubscriptionDurationScreen> {
  int? _selectedDuration;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SubscriptionBloc, SubscriptionState>(
      listener: (_, state) async {
        if (state is DeliveryTimeInput && state.push) {
          await subscriptionNavigator
              .pushNamed(SubscriptionRoutes.deliveryTime);
          context.subscription.add(BackPressed());
        }
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
        bottomNavigationBar: _buildNextButton(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return WaterAppBar(
      title: WaterText(
        'screen.duration'.tr(),
        fontSize: 24.0,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w800,
        color: AppColors.primaryText,
      ),
      leading: AppBarBackButton(
        onPressed: () {
          subscriptionNavigator.pop();
        },
      ),
      actions: [
        AppBarWhatsappButton(),
        AppBarNotificationButton(),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      physics: const BouncingScrollPhysics(),
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: isMobile ? 100.w : 50.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHintText(),
              const SizedBox(height: 24.0),
              _buildSubscriptionDurationPicker(),
              if (_selectedDuration != null) _buildSelectedDurationText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHintText() {
    return WaterText(
      'text.select_duration'.tr(),
      fontSize: 16.0,
      lineHeight: 1.5,
      textAlign: TextAlign.center,
      fontWeight: FontWeight.w600,
      color: AppColors.primaryText,
    );
  }

  Widget _buildSubscriptionDurationPicker() {
    return SubscriptionDurationPicker(
      onSelected: (months) {
        setState(() => _selectedDuration = months);
      },
    );
  }

  Widget _buildSelectedDurationText() {
    return Column(
      children: [
        WaterText(
          'text.selected_duration'.tr(),
          fontSize: 18.0,
          lineHeight: 1.75,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w700,
          color: AppColors.primaryText,
        ).withPadding(0.0, 40.0, 0.0, 0.0),
        WaterText(
          'text.months'.plural(_selectedDuration!),
          fontSize: 18.0,
          lineHeight: 1.75,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w700,
          color: AppColors.secondaryText,
        ).withPadding(0.0, 32.0, 0.0, 0.0),
      ],
    );
  }

  Widget _buildNextButton() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        border: Border(top: defaultBorder),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          WaterButton(
            enabled: _selectedDuration != null,
            onPressed: () {
              context.subscription.add(
                SubmitSubscriptionDuration(months: _selectedDuration!),
              );
            },
            text: 'button.next'.tr(),
          ),
        ],
      ),
    );
  }
}
