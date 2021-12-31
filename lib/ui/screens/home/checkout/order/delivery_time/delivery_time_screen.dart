import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/checkout/dates/dates_bloc.dart';
import 'package:water/bloc/home/checkout/order/order_bloc.dart';
import 'package:water/domain/model/delivery/date.dart';
import 'package:water/ui/screens/home/checkout/order/order_navigator.dart';
import 'package:water/ui/screens/home/checkout/widgets/delivery_time_picker.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/utils/localization.dart';

class DeliveryTimeScreen extends StatefulWidget {
  DeliveryTimeScreen({Key? key}) : super(key: key);

  @override
  _DeliveryTimeScreenState createState() => _DeliveryTimeScreenState();
}

class _DeliveryTimeScreenState extends State<DeliveryTimeScreen> {
  DeliveryTime? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderBloc, OrderState>(
      listener: (_, state) async {
        if (state is OrderDetailsCollected && state.push) {
          await orderNavigator.pushNamed(OrderRoutes.orderPayment);
          context.order.add(BackPressed());
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
        'screen.time'.tr(),
        fontSize: 24.0,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w800,
        color: AppColors.primaryText,
      ),
      leading: AppBarBackButton(
        onPressed: () {
          orderNavigator.pop();
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
      child: SingleChildScrollView(
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
                _buildDeliveryTimePicker(),
                if (_selectedTime != null) _buildSelectedTimeText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHintText() {
    return WaterText(
      'text.select_time'.tr(),
      fontSize: 16.0,
      lineHeight: 1.5,
      textAlign: TextAlign.center,
      fontWeight: FontWeight.w600,
      color: AppColors.primaryText,
    );
  }

  Widget _buildDeliveryTimePicker() {
    return BlocBuilder<DeliveryDatesBloc, DeliveryDatesState>(
      builder: (context, state) {
        context.showLoader(state is DeliveryDatesLoading);

        if (state is DeliveryDatesLoaded) {
          return DeliveryTimePicker(
            dates: state.dates,
            onSelected: (time) {
              setState(() => _selectedTime = time);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildSelectedTimeText() {
    final locale = Localization.currentLocale(context).languageCode;
    final formattedDayOfMonth =
        DateFormat('MMMM d', locale).format(_selectedTime!.date);
    final startTime =
        DateFormat('h').parse('${_selectedTime!.period.startTime}');
    final endTime = DateFormat('h').parse('${_selectedTime!.period.endTime}');
    final formattedStartDate = DateFormat('h a', locale).format(startTime);
    final formattedEndTime = DateFormat('h a', locale).format(endTime);

    return Column(
      children: [
        WaterText(
          'text.selected_time'.tr(),
          fontSize: 18.0,
          lineHeight: 1.75,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w700,
          color: AppColors.primaryText,
        ).withPadding(0.0, 40.0, 0.0, 0.0),
        WaterText(
          formattedDayOfMonth,
          fontSize: 18.0,
          lineHeight: 1.75,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w700,
          color: AppColors.secondaryText,
        ).withPadding(0.0, 32.0, 0.0, 0.0),
        WaterText(
          '$formattedStartDate - $formattedEndTime',
          fontSize: 18.0,
          lineHeight: 1.75,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w700,
          color: AppColors.secondaryText,
        ).withPadding(0.0, 4.0, 0.0, 0.0),
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
            enabled: _selectedTime != null,
            onPressed: () {
              context.order.add(
                SubmitDeliveryTime(time: _selectedTime!),
              );
            },
            text: 'button.next'.tr(),
          ),
        ],
      ),
    );
  }
}
