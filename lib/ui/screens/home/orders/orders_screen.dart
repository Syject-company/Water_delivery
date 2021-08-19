import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/orders/orders_bloc.dart';
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
        'screen.orders'.tr(),
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
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        if (state is OrdersLoaded) {
          return SeparatedColumn(
            children: state.orders
                .map(
                  (order) => OrderListItem(
                    key: ValueKey(order),
                    order: order,
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
}
