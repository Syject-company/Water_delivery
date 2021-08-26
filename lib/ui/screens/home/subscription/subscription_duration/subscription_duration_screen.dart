import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/checkout/subscription/subscription_bloc.dart';
import 'package:water/ui/screens/home/subscription/subscription_navigator.dart';
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
      listener: (context, state) async {
        if (state is DeliveryTimeInput && state.push) {
          await subscriptionNavigator
              .pushNamed(SubscriptionRoutes.deliveryTime);
          context.subscription.add(BackPressed());
        }
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              WaterText(
                'text.select_duration'.tr(),
                fontSize: 15.0,
                lineHeight: 1.5,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryText,
              ),
              const SizedBox(height: 24.0),
              SubscriptionDurationPicker(
                onSelected: (months) {
                  setState(() => _selectedDuration = months);
                },
              ),
              if (_selectedDuration != null) _buildSelectedDurationText(),
            ],
          ),
        ),
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
      ),
      leading: AppBarBackButton(
        onPressed: () {
          subscriptionNavigator.pop();
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

  Widget _buildSelectedDurationText() {
    return Column(
      children: [
        WaterText(
          'text.selected_duration'.tr(),
          fontSize: 18.0,
          lineHeight: 1.75,
          textAlign: TextAlign.center,
        ).withPadding(0.0, 40.0, 0.0, 0.0),
        WaterText(
          'text.months'.plural(_selectedDuration!),
          fontSize: 18.0,
          lineHeight: 1.75,
          textAlign: TextAlign.center,
          color: AppColors.secondaryText,
        ).withPadding(0.0, 32.0, 0.0, 0.0),
      ],
    );
  }

  Widget _buildNextButton() {
    return WaterButton(
      enabled: _selectedDuration != null,
      onPressed: () {
        context.subscription.add(
          SubmitSubscriptionDuration(months: _selectedDuration!),
        );
      },
      text: 'button.next'.tr(),
    ).withPaddingAll(24.0);
  }
}
