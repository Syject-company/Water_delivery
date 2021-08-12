import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/extensions/navigator.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/localization.dart';

import '../home_navigator.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        physics: const BouncingScrollPhysics(),
        child: _buildOrderItems(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return WaterAppBar(
      title: WaterText(
        'Orders',
        fontSize: 24.0,
        textAlign: TextAlign.center,
      ),
      leading: AppBarBackButton(
        onPressed: () => homeNavigator.pop(),
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

  Widget _buildOrderItems(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildOrderItem(context),
        _buildOrderItem(context),
        _buildOrderItem(context),
      ],
    );
  }

  Widget _buildOrderItem(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildDeliveryAddress(),
        const SizedBox(height: 6.0),
        _buildDeliveryTime(context),
      ],
    );
  }

  Widget _buildDeliveryAddress() {
    return Row(
      children: <Widget>[
        Icon(
          AppIcons.pin,
          size: 32.0,
          color: AppColors.secondaryText,
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: WaterText(
            'emirate, district, address, building, floor, apartment',
            fontSize: 12.0,
            lineHeight: 1.25,
            fontWeight: FontWeight.w400,
            color: AppColors.secondaryText,
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryTime(BuildContext context) {
    final locale = Localization.currentLocale(context).languageCode;
    final date = DateFormat('yyyy-MM-dd').parse('2021-08-12');
    final formattedDayOfWeek = DateFormat('EEEE', locale).format(date);
    final startTime = DateFormat('h').parse('1');
    final endTime = DateFormat('h').parse('8');
    final formattedStartTime = DateFormat('h a', locale).format(startTime);
    final formattedEndTime = DateFormat('h a', locale).format(endTime);

    return Row(
      children: <Widget>[
        Icon(
          AppIcons.time,
          size: 32.0,
          color: AppColors.secondaryText,
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: WaterText(
            '$formattedDayOfWeek  $formattedStartTime - $formattedEndTime',
            fontSize: 12.0,
            lineHeight: 1.25,
            fontWeight: FontWeight.w400,
            color: AppColors.secondaryText,
          ),
        ),
      ],
    );
  }
}
