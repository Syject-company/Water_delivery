import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/cart/cart_bloc.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/extensions/navigator.dart';
import 'package:water/ui/extensions/widget.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/screens/home/router.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/separated_column.dart';

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
      builder: (context, state) {
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
        color: AppColors.secondaryText,
      ),
    );
  }

  Widget _buildCartItems(CartState state) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SeparatedColumn(
        children: state.items
            .map(
              (item) => CartListItem(
                key: ValueKey(item),
                cartItem: item,
              ),
            ).toList(),
        separator: const Divider(
          color: AppColors.borderColor,
          thickness: 1.0,
          height: 1.0,
        ),
        includeOuterSeparators: true,
      ),
    );
  }

  Widget _buildBottomPanel(CartState state) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 24.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.borderColor),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDiscountPriceText(),
          const SizedBox(height: 4.0),
          _buildTotalPriceText(state),
          const SizedBox(height: 20.0),
          _buildActionButtons(state),
        ],
      ),
    );
  }

  Widget _buildDiscountPriceText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WaterText(
          'text.fee'.tr(),
          fontSize: 18.0,
          lineHeight: 1.5,
          fontWeight: FontWeight.w500,
          color: AppColors.secondaryText,
        ),
        const SizedBox(width: 16.0),
        Flexible(
          child: WaterText(
            'text.aed'.tr(args: [0.toStringAsFixed(2)]),
            fontSize: 18.0,
            lineHeight: 1.5,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.end,
            color: AppColors.secondaryText,
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
        ),
        const SizedBox(width: 24.0),
        Flexible(
          child: WaterText(
            'text.aed'.tr(args: [totalPrice.toStringAsFixed(2)]),
            fontSize: 23.0,
            lineHeight: 2.0,
            textAlign: TextAlign.end,
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
          child: WaterButton(
            onPressed: () {},
            text: 'button.subscription'.tr(),
            backgroundColor: AppColors.secondary,
            foregroundColor: AppColors.primary,
            enabled: false,
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: WaterButton(
            onPressed: () {
              homeNavigator.pushNamed(HomeRoutes.delivery);
            },
            text: 'button.checkout'.tr(),
            enabled: !isCartEmpty,
          ),
        ),
      ],
    );
  }
}
