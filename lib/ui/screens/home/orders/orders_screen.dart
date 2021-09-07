import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/orders/orders_bloc.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/separated_column.dart';

import 'widgets/order_list_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
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

  Widget _buildBody() {
    return LoaderOverlay(
      child: _buildOrderItems(),
    );
  }

  Widget _buildOrderItems() {
    return BlocConsumer<OrdersBloc, OrdersState>(
      listener: (context, state) {
        context.showLoader(state is OrdersLoading);
      },
      builder: (_, state) {
        if (state is OrdersLoaded) {
          if (state.orders.isEmpty) {
            return _buildNoOrdersText();
          }

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SeparatedColumn(
              children: state.orders.map((order) {
                return OrderListItem(
                  key: ValueKey(order),
                  order: order,
                );
              }).toList(),
              includeOuterSeparators: true,
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildNoOrdersText() {
    return Center(
      child: WaterText(
        'There are not orders yet',
        fontSize: 20.0,
        color: AppColors.secondaryText,
      ),
    );
  }
}
