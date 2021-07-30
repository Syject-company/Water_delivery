import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/cart/cart_bloc.dart';
import 'package:water/domain/model/home/cart_item.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/shared_widgets/button/button.dart';
import 'package:water/ui/shared_widgets/text/animated_text.dart';
import 'package:water/ui/shared_widgets/text/text.dart';

import 'widget/cart_list_item.dart';

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
      listener: (_, state) {
        final totalPrice = state.totalPrice;
        _totalPriceTextKey.currentState!.setNewValue(
          '\$${totalPrice.toStringAsFixed(2)}',
          reverse: totalPrice < _lastTotalPrice,
        );
        _lastTotalPrice = totalPrice;
      },
      builder: (_, state) {
        return Column(
          children: <Widget>[
            state.items.isNotEmpty
                ? _buildItems(state)
                : _buildEmptyCartText(),
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildBottomPanel(state),
            )
          ],
        );
      },
    );
  }

  Widget _buildEmptyCartText() {
    return Expanded(
      child: Center(
        child: WaterText(
          'Cart is Empty',
          fontSize: 20.0,
          color: AppColors.secondaryText,
        ),
      ),
    );
  }

  Widget _buildItems(CartState state) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: _separateItems(state.items),
        ),
      ),
    );
  }

  List<Widget> _separateItems(List<CartItem> items) {
    final separatedItems = <Widget>[];

    if (items.length > 0) {
      separatedItems.add(_buildDivider());
      items.forEach(
        (item) => separatedItems.addAll([
          CartListItem(item, key: ValueKey(item)),
          _buildDivider(),
        ]),
      );
    }

    return separatedItems;
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1.0,
      thickness: 1.0,
      color: AppColors.borderColor,
    );
  }

  Widget _buildBottomPanel(CartState state) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.borderColor)),
      ),
      child: Column(
        children: <Widget>[
          _buildDiscountPriceText(),
          const SizedBox(height: 8.0),
          _buildTotalPriceText(state),
          const SizedBox(height: 16.0),
          _buildActionButtons(),
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
          Expanded(
            child: WaterText(
              'Fee',
              fontSize: 18.0,
              lineHeight: 1.5,
              fontWeight: FontWeight.w500,
              color: AppColors.secondaryText,
            ),
          ),
          const SizedBox(width: 24.0),
          Expanded(
            child: WaterText(
              '\$0.00',
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: WaterText(
              'Total',
              fontSize: 23.0,
              lineHeight: 2.0,
            ),
          ),
          const SizedBox(width: 24.0),
          Expanded(
            child: AnimatedWaterText(
              '\$${(_lastTotalPrice = state.totalPrice).toStringAsFixed(2)}',
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

  Widget _buildActionButtons() {
    return Row(
      children: <Widget>[
        Expanded(
          child: WaterButton(
            onPressed: () {},
            text: 'Subscription',
            backgroundColor: AppColors.secondary,
            foregroundColor: AppColors.primary,
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: WaterButton(
            onPressed: () {},
            text: 'Check Out',
          ),
        ),
      ],
    );
  }
}