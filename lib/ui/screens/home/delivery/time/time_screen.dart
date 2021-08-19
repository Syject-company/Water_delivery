import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/delivery/date/date_bloc.dart';
import 'package:water/bloc/home/delivery/delivery_bloc.dart';
import 'package:water/domain/model/home/delivery/date.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/extensions/navigator.dart';
import 'package:water/ui/extensions/widget.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/screens/home/delivery/delivery_navigator.dart';
import 'package:water/ui/screens/home/delivery/router.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/localization.dart';

import 'widgets/delivery_time_picker.dart';

class DeliveryTimeScreen extends StatefulWidget {
  DeliveryTimeScreen({Key? key}) : super(key: key);

  @override
  _DeliveryTimeScreenState createState() => _DeliveryTimeScreenState();
}

class _DeliveryTimeScreenState extends State<DeliveryTimeScreen> {
  DeliveryTime? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeliveryBloc, DeliveryState>(
      listener: (context, state) async {
        if (state is DeliveryDetailsCollected && state.push) {
          await deliveryNavigator.pushNamed(DeliveryRoutes.payment);
          context.delivery.add(BackPressed());
        }
      },
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              WaterText(
                'text.select_time'.tr(),
                lineHeight: 1.5,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryText,
              ),
              const SizedBox(height: 24.0),
              BlocBuilder<DeliveryDateBloc, DeliveryDateState>(
                builder: (context, state) {
                  if (state is DeliveryDatesLoaded) {
                    return Column(
                      children: [
                        DeliveryTimePicker(
                          times: state.dates,
                          onSelected: (time) {
                            setState(() => _selectedTime = time);
                          },
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              if (_selectedTime != null) _buildSelectedTimeText(),
            ],
          ),
        ),
        bottomNavigationBar: _buildNextButton(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return WaterAppBar(
      title: WaterText(
        'screen.time'.tr(),
        fontSize: 24.0,
        textAlign: TextAlign.center,
      ),
      leading: AppBarBackButton(
        onPressed: () {
          deliveryNavigator.pop();
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

  Widget _buildSelectedTimeText() {
    final locale = Localization.currentLocale(context).languageCode;
    final date = DateFormat('yyyy-MM-dd').parse(_selectedTime!.date);
    final formattedDayOfMonth = DateFormat('MMMM d', locale).format(date);
    final startTime =
        DateFormat('h').parse('${_selectedTime!.period.startTime}');
    final endTime = DateFormat('h').parse('${_selectedTime!.period.endTime}');
    final formattedStartDate = DateFormat('h a', locale).format(startTime);
    final formattedEndTime = DateFormat('h a', locale).format(endTime);

    return Column(
      children: [
        const SizedBox(height: 40.0),
        WaterText(
          'text.selected_time'.tr(),
          fontSize: 18.0,
          lineHeight: 1.75,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32.0),
        WaterText(
          formattedDayOfMonth,
          fontSize: 18.0,
          lineHeight: 1.75,
          textAlign: TextAlign.center,
          color: AppColors.secondaryText,
        ),
        const SizedBox(height: 4.0),
        WaterText(
          '$formattedStartDate - $formattedEndTime',
          fontSize: 18.0,
          lineHeight: 1.75,
          textAlign: TextAlign.center,
          color: AppColors.secondaryText,
        ),
      ],
    );
  }

  Widget _buildNextButton() {
    return WaterButton(
      enabled: _selectedTime != null,
      onPressed: () {
        context.delivery.add(
          SubmitDeliveryTime(time: _selectedTime!),
        );
      },
      text: 'button.next'.tr(),
    ).withPaddingAll(24.0);
  }
}
