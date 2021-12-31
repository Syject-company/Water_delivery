import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/orders/orders_bloc.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';

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
      child: _buildOrderItems(),
    );
  }

  Widget _buildOrderItems() {
    return BlocConsumer<OrdersBloc, OrdersState>(
      listener: (context, state) {
        context.showLoader(state is OrdersLoading);

        if (state is OrdersError) {
          showWaterDialog(context, ErrorAlert());
        }
      },
      builder: (context, state) {
        if (state is OrdersLoaded) {
          if (state.orders.isEmpty) {
            return _buildNoOrdersText();
          }

          return SizedBox.expand(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SeparatedColumn(
                includeOuterSeparators: true,
                separator: defaultDivider,
                children: state.orders.map((order) {
                  return OrderListItem(
                    key: ValueKey(order),
                    order: order,
                  );
                }).toList(growable: false),
              ),
            ),
          );
        } else if (state is OrdersError) {
          return _buildTryAgainButton(context);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildNoOrdersText() {
    return Center(
      child: WaterText(
        'text.no_orders'.tr(),
        fontSize: 20.0,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w700,
        color: AppColors.secondaryText,
      ),
    ).withPaddingAll(24.0);
  }

  Widget _buildTryAgainButton(BuildContext context) {
    return Center(
      child: WaterButton(
        onPressed: () {
          context.orders.add(
            LoadOrders(),
          );
        },
        text: 'button.try_again'.tr(),
      ),
    ).withPaddingAll(24.0);
  }
}
