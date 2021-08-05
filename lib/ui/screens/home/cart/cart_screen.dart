import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/cart/cart_bloc.dart';
import 'package:water/domain/model/home/cart_item.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/screens/home/router.dart';
import 'package:water/ui/shared_widgets/button/button.dart';
import 'package:water/ui/shared_widgets/text/animated_text.dart';
import 'package:water/ui/shared_widgets/text/text.dart';

import 'widgets/cart_list_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final GlobalKey<AnimatedWaterTextState> _totalPriceTextKey = GlobalKey();

  double _lastTotalPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        final totalPrice = state.totalPrice;
        _totalPriceTextKey.currentState!.setNewValue(
          'text.aed'.tr(args: [totalPrice.toStringAsFixed(2)]),
          reverse: totalPrice < _lastTotalPrice,
        );
        _lastTotalPrice = totalPrice;
      },
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
      child: Column(
        children: _separateItems(state.items),
      ),
    );
  }

  List<Widget> _separateItems(List<CartItem> items) {
    final separatedItems = <Widget>[]..add(_buildDivider());

    items.forEach(
      (item) => separatedItems.addAll([
        CartListItem(key: ValueKey(item), cartItem: item),
        _buildDivider(),
      ]),
    );

    return separatedItems;
  }

  Widget _buildDivider() {
    return const Divider(
      color: AppColors.borderColor,
      thickness: 1.0,
      height: 1.0,
    );
  }

  Widget _buildBottomPanel(CartState state) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.borderColor)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildDiscountPriceText(),
          const SizedBox(height: 8.0),
          _buildTotalPriceText(state),
          const SizedBox(height: 16.0),
          _buildActionButtons(state),
        ],
      ),
    );
  }

  Widget _buildDiscountPriceText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
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
              'text.aed'.tr(args: ['0.00']),
              fontSize: 18.0,
              lineHeight: 1.5,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.end,
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalPriceText(CartState state) {
    final totalPrice = _lastTotalPrice = state.totalPrice;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          WaterText(
            'text.total'.tr(),
            fontSize: 23.0,
            lineHeight: 2.0,
          ),
          const SizedBox(width: 24.0),
          Flexible(
            child: AnimatedWaterText(
              'text.aed'.tr(args: [totalPrice.toStringAsFixed(2)]),
              key: _totalPriceTextKey,
              fontSize: 23.0,
              lineHeight: 2.0,
              textAlign: TextAlign.end,
              alignment: AlignmentDirectional.centerEnd,
              duration: const Duration(milliseconds: 250),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(CartState state) {
    final isCartEmpty = state.items.isEmpty;

    return Row(
      children: <Widget>[
        Expanded(
          child: WaterButton(
            onPressed: () {},
            text: 'button.subscription'.tr(),
            backgroundColor:
                isCartEmpty ? AppColors.disabled : AppColors.secondary,
            foregroundColor: isCartEmpty ? AppColors.white : AppColors.primary,
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: WaterButton(
            onPressed: () {
              if (!isCartEmpty) {
                homeNavigator.currentState!.pushNamed(HomeRoutes.delivery);
              }
            },
            text: 'button.checkout'.tr(),
            backgroundColor:
                isCartEmpty ? AppColors.disabled : AppColors.primary,
            foregroundColor: isCartEmpty ? AppColors.white : AppColors.white,
          ),
        ),
      ],
    );
  }
}
