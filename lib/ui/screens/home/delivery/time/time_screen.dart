import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/delivery/delivery_bloc.dart';
import 'package:water/domain/model/home/delivery/delivery_time.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/extensions/navigator.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/screens/home/delivery/delivery_navigator.dart';
import 'package:water/ui/screens/home/delivery/router.dart';
import 'package:water/ui/screens/home/delivery/time/widgets/delivery_time_picker.dart';
import 'package:water/ui/shared_widgets/water.dart';

class TimeScreen extends StatefulWidget {
  TimeScreen({Key? key}) : super(key: key);

  @override
  _TimeScreenState createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {
  SelectedTime? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            WaterText(
              'Select a convenient delivery time for your district',
              lineHeight: 1.5,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
              color: AppColors.secondaryText,
            ),
            const SizedBox(height: 24.0),
            BlocBuilder<DeliveryBloc, DeliveryState>(
              builder: (context, state) {
                if (state is DeliveryTimesLoaded) {
                  return DeliveryTimePicker(
                    times: state.times,
                    onSelected: (time) {
                      setState(() => _selectedTime = time);
                    },
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
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return WaterAppBar(
      title: WaterText(
        'Time',
        fontSize: 24.0,
        textAlign: TextAlign.center,
      ),
      leading: AppBarBackButton(
        onPressed: () {
          deliveryNavigator.pop();
        },
      ),
      actions: <Widget>[
        AppBarIconButton(
          onPressed: () {},
          icon: AppIcons.whatsapp,
        ),
        AppBarNotificationButton(),
      ],
    );
  }

  Widget _buildSelectedTimeText() {
    final date = DateFormat('yyyy-MM-dd').parse(_selectedTime!.date);
    final formattedDayOfMonth = DateFormat('MMMM d').format(date);
    final startTime =
        DateFormat('h').parse('${_selectedTime!.period.startTime}');
    final endTime = DateFormat('h').parse('${_selectedTime!.period.endTime}');
    final formattedStartDate = DateFormat('h a').format(startTime);
    final formattedEndTime = DateFormat('h a').format(endTime);

    return Column(
      children: <Widget>[
        const SizedBox(height: 40.0),
        WaterText(
          'Selected time:',
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
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: WaterButton(
        enabled: _selectedTime != null,
        onPressed: () {
          deliveryNavigator.pushNamed(DeliveryRoutes.payment);
        },
        text: 'button.next'.tr(),
      ),
    );
  }
}
