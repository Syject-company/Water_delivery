import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/cart/cart_bloc.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/utils/session.dart';

import 'widgets/cart_list_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (_, state) {
        return Scaffold(
          body: state.items.isNotEmpty
              ? _buildCartItems(state)
              : _buildEmptyCartText(),
          bottomNavigationBar: _buildBottomPanel(state),
        );
      },
    );
  }

  Widget _buildEmptyCartText() {
    return Center(
      child: WaterText(
        'text.empty_cart'.tr(),
        fontSize: 20.0,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w700,
        color: AppColors.secondaryText,
      ),
    );
  }

  Widget _buildCartItems(CartState state) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SeparatedColumn(
        includeOuterSeparators: true,
        separator: defaultDivider,
        children: state.items.map((item) {
          return CartListItem(
            key: ValueKey(item),
            cartItem: item,
          );
        }).toList(growable: false),
      ),
    );
  }

  Widget _buildBottomPanel(CartState state) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 24.0),
      decoration: BoxDecoration(
        border: Border(top: defaultBorder),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildVATText(state),
          const SizedBox(height: 4.0),
          _buildTotalPriceText(state),
          const SizedBox(height: 20.0),
          _buildActionButtons(state),
        ],
      ),
    );
  }

  Widget _buildVATText(CartState state) {
    final vat = state.vat;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WaterText(
          'text.vat'.tr(),
          fontSize: 18.0,
          lineHeight: 1.5,
          fontWeight: FontWeight.w700,
          color: AppColors.secondaryText,
        ),
        const SizedBox(width: 16.0),
        Flexible(
          child: WaterText(
            'text.aed'.tr(args: [
              vat.toStringAsFixed(2),
            ]),
            fontSize: 18.0,
            lineHeight: 1.5,
            textAlign: TextAlign.end,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryText,
          ),
        ),
      ],
    ).withPadding(12.0, 0.0, 12.0, 0.0);
  }

  Widget _buildTotalPriceText(CartState state) {
    final totalPrice = state.totalPrice;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WaterText(
          'text.total'.tr(),
          fontSize: 23.0,
          lineHeight: 2.0,
          fontWeight: FontWeight.w700,
          color: AppColors.primaryText,
        ),
        const SizedBox(width: 24.0),
        Flexible(
          child: WaterText(
            'text.aed'.tr(args: [
              totalPrice.toStringAsFixed(2),
            ]),
            fontSize: 23.0,
            lineHeight: 2.0,
            textAlign: TextAlign.end,
            fontWeight: FontWeight.w800,
            color: AppColors.primaryText,
          ),
        ),
      ],
    ).withPadding(12.0, 0.0, 12.0, 0.0);
  }

  Widget _buildActionButtons(CartState state) {
    final isCartEmpty = state.items.isEmpty;

    return Row(
      children: [
        Expanded(
          child: WaterSecondaryButton(
            onPressed: () {
              if (Session.isAuthenticated) {
                homeNavigator.pushNamed(HomeRoutes.subscription);
              } else {
                homeNavigator.pushNamed(HomeRoutes.auth);
              }
            },
            text: 'button.subscription'.tr(),
            enabled: !isCartEmpty,
            radialRadius: 2.0,
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: WaterButton(
            onPressed: () {
              if (Session.isAuthenticated) {
                homeNavigator.pushNamed(HomeRoutes.order);
              } else {
                homeNavigator.pushNamed(HomeRoutes.auth);
              }
            },
            text: 'button.checkout'.tr(),
            enabled: !isCartEmpty,
          ),
        ),
      ],
    );
  }
}
