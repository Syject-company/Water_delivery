import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/extensions/navigator.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/separated_column.dart';

import 'widgets/order_list_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 24.0),
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

  Widget _buildOrderItems(BuildContext context) {
    return SeparatedColumn(
      children: [
        OrderListItem(),
        OrderListItem(),
        OrderListItem(),
      ],
      separator: const Divider(
        height: 1.0,
        thickness: 1.0,
        color: AppColors.borderColor,
      ),
      includeOuterSeparators: true,
    );
  }
}
