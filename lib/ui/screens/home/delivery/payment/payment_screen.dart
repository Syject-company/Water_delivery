import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/cart/cart_bloc.dart';
import 'package:water/bloc/home/wallet/wallet_bloc.dart';
import 'package:water/domain/model/home/cart_item.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/extensions/navigator.dart';
import 'package:water/ui/extensions/product.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/screens/home/delivery/delivery_navigator.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/screens/home/router.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/separated_column.dart';

class PaymentScreen extends StatefulWidget {
  PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Column(
        children: <Widget>[
          _buildBalanceText(),
          _buildSummary(),
        ],
      ),
      bottomNavigationBar: _buildBottomPanel(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return WaterAppBar(
      title: WaterText(
        'screen.payment'.tr(),
        fontSize: 24.0,
        textAlign: TextAlign.center,
      ),
      leading: AppBarBackButton(
        onPressed: () => deliveryNavigator.pop(),
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

  Widget _buildBalanceText() {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: WaterText(
            'text.wallet_balance'.tr(args: [state.balance.toStringAsFixed(2)]),
            fontSize: 18.0,
            lineHeight: 1.5,
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  Widget _buildSummary() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.fromLTRB(24.0, 18.0, 24.0, 18.0),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.borderColor),
            bottom: BorderSide(color: AppColors.borderColor),
          ),
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  AppIcons.pin,
                  size: 32.0,
                  color: AppColors.secondaryText,
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: WaterText(
                    'Alqasim Alkhawarizmi St, Ar Rakah Ash Shamaliyah Dammam 34225, Saudi Arabia',
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryText,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6.0),
            Row(
              children: <Widget>[
                Icon(
                  AppIcons.time,
                  size: 32.0,
                  color: AppColors.secondaryText,
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: WaterText(
                    'Tuesday  15:00 - 18:00',
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryText,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            _buildCartItems(),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItems() {
    final items = context.cart.state.items;

    return SeparatedColumn(
      children: <Widget>[
        for (int i = 0; i < items.length; i++) _buildCartItem(i, items[i]),
      ],
      separator: const SizedBox(height: 6.0),
    );
  }

  Widget _buildCartItem(int index, CartItem item) {
    final title = item.product.title.tr();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        WaterText(
          '${index + 1}.',
          fontSize: 15.0,
          lineHeight: 1.5,
          fontWeight: FontWeight.w500,
          color: AppColors.secondaryText,
        ),
        const SizedBox(width: 3.0),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              WaterText(
                '$title',
                fontSize: 15.0,
                lineHeight: 1.5,
                fontWeight: FontWeight.w500,
                color: AppColors.secondaryText,
              ),
            ],
          ),
        ),
        const SizedBox(width: 12.0),
        WaterText(
          'x${item.amount}',
          fontSize: 15.0,
          lineHeight: 1.5,
          fontWeight: FontWeight.w500,
          color: AppColors.secondaryText,
        ),
        const SizedBox(width: 12.0),
        Expanded(
          flex: 2,
          child: WaterText(
            'text.aed'.tr(args: [
              item.totalDiscountPrice.toStringAsFixed(2),
            ]),
            fontSize: 15.0,
            lineHeight: 1.5,
            textAlign: TextAlign.end,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomPanel() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.borderColor),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildDiscountPriceText(),
          const SizedBox(height: 4.0),
          _buildTotalPriceText(),
          const SizedBox(height: 20.0),
          _buildPayButton(),
        ],
      ),
    );
  }

  Widget _buildDiscountPriceText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
              'text.aed'.tr(args: [0.toStringAsFixed(2)]),
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

  Widget _buildTotalPriceText() {
    final totalPrice = context.cart.state.totalPrice;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
            child: WaterText(
              'text.aed'.tr(args: [totalPrice.toStringAsFixed(2)]),
              fontSize: 23.0,
              lineHeight: 2.0,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPayButton() {
    final balance = context.wallet.state.balance;
    final totalPrice = context.cart.state.totalPrice;

    return WaterButton(
      onPressed: () async {
        if (balance < totalPrice) {
          await _showDialog(_TopUpWalletDialog());
        } else {
          await _showDialog(_SuccessfulPaymentDialog());
          context.wallet.add(RemoveBalance(amount: totalPrice));
          context.cart.add(ClearCart());
          homeNavigator.pop();
        }
      },
      text: 'button.pay'.tr(),
    );
  }

  Future<void> _showDialog(Widget dialog) async {
    return showDialog(
      context: context,
      builder: (context) => dialog,
      barrierDismissible: false,
    );
  }
}

class _SuccessfulPaymentDialog extends StatelessWidget {
  const _SuccessfulPaymentDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0.0,
      titlePadding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 32.0),
      contentPadding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(19.0),
      ),
      title: _buildTitle(),
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildMessageText(),
            const SizedBox(height: 32.0),
            _buildAddButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: <Widget>[
        Icon(
          AppIcons.logo,
          size: 96.0,
          color: AppColors.secondary,
        ),
        const SizedBox(height: 16.0),
        WaterText(
          'text.successful_payment'.tr(),
          fontSize: 18.0,
          lineHeight: 1.5,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildMessageText() {
    return WaterText(
      'text.thanks_for_order'.tr(),
      fontSize: 16.0,
      lineHeight: 1.25,
      textAlign: TextAlign.center,
      color: AppColors.secondaryText,
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return WaterButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      text: 'button.ok'.tr(),
    );
  }
}

class _TopUpWalletDialog extends StatelessWidget {
  const _TopUpWalletDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0.0,
      titlePadding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 32.0),
      contentPadding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(19.0),
      ),
      title: _buildTitle(context),
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildMessageText(),
            const SizedBox(height: 32.0),
            _buildAddButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        PositionedDirectional(
          top: 0.0,
          end: 0.0,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              AppIcons.close,
              size: 32.0,
              color: AppColors.secondaryText,
            ),
            behavior: HitTestBehavior.opaque,
          ),
        ),
        Column(
          children: <Widget>[
            Icon(
              AppIcons.alert,
              size: 96.0,
              color: AppColors.secondary,
            ),
            const SizedBox(height: 16.0),
            WaterText(
              'text.top_up_wallet'.tr(),
              fontSize: 18.0,
              lineHeight: 1.5,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMessageText() {
    return WaterText(
      'text.not_enough_money'.tr(),
      fontSize: 16.0,
      lineHeight: 1.25,
      fontWeight: FontWeight.w500,
      textAlign: TextAlign.center,
      color: AppColors.secondaryText,
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return WaterButton(
      onPressed: () {
        homeNavigator.pushNamed(HomeRoutes.wallet);
        Navigator.of(context).pop();
      },
      text: 'button.top_up'.tr(),
    );
  }
}
