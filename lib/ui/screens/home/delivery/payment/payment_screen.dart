import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:water/bloc/home/cart/cart_bloc.dart';
import 'package:water/bloc/home/wallet/wallet_bloc.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/constants/paths.dart';
import 'package:water/ui/extensions/navigator.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/screens/home/delivery/delivery_navigator.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/screens/home/router.dart';
import 'package:water/ui/shared_widgets/water.dart';

import 'widgets/credit_card_form.dart';
import 'widgets/wallet_form.dart';

enum PaymentType { creditCard, wallet }

class PaymentScreen extends StatefulWidget {
  PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentType _currentPaymentType = PaymentType.creditCard;

  final Map<PaymentType, Widget> _paymentForms = {
    PaymentType.creditCard: CreditCardForm(),
    PaymentType.wallet: WalletForm(),
  };

  static Widget _defaultLayoutBuilder(List<Widget> entries) {
    return Stack(
      children: entries,
      alignment: Alignment.topCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildPaymentPicker(),
            const SizedBox(height: 32.0),
            PageTransitionSwitcher(
              layoutBuilder: _defaultLayoutBuilder,
              duration: const Duration(milliseconds: 375),
              reverse: _currentPaymentType == PaymentType.creditCard,
              transitionBuilder: (child, animation, secondaryAnimation) {
                return SharedAxisTransition(
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.horizontal,
                  fillColor: AppColors.white,
                  child: child,
                );
              },
              child: _paymentForms[_currentPaymentType],
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomPanel(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return WaterAppBar(
      title: WaterText(
        'Payment',
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

  Widget _buildPaymentPicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: WaterRadioGroup<PaymentType>(
        onChanged: (type) {
          setState(() => _currentPaymentType = type);
        },
        initialValue: _currentPaymentType,
        values: {
          PaymentType.creditCard: 'Credit Card',
          PaymentType.wallet: 'Wallet',
        },
        axis: Axis.horizontal,
        spaceBetween: 0.0,
        labelFontSize: 15.0,
        labelLineHeight: 1.25,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
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
    final totalPrice = context.cart.state.totalPrice;
    final balance = context.wallet.state.balance;

    return WaterButton(
      onPressed: () {
        switch (_currentPaymentType) {
          case PaymentType.creditCard:
            break;
          case PaymentType.wallet:
            _showDialog(balance >= totalPrice
                ? _SuccessfulPaymentDialog()
                : _TopUpWalletDialog());
            break;
        }
      },
      text: 'Pay',
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
      titlePadding: const EdgeInsets.fromLTRB(24.0, 18.0, 24.0, 18.0),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: <Widget>[
          SvgPicture.asset(
            Paths.logo_icon,
            height: 110.0,
            color: AppColors.secondary,
          ),
          const SizedBox(height: 16.0),
          WaterText(
            'Successful Payment!',
            fontSize: 18.0,
            lineHeight: 1.5,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMessageText() {
    return WaterText(
      'Thanks a lot for your order. Wait for the delivery.',
      fontSize: 16.0,
      lineHeight: 1.25,
      textAlign: TextAlign.center,
      color: AppColors.secondaryText,
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return WaterButton(
      onPressed: () {
        homeNavigator.pop();
        Navigator.of(context).pop();
      },
      text: 'OK',
    );
  }
}

class _TopUpWalletDialog extends StatelessWidget {
  const _TopUpWalletDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0.0,
      titlePadding: const EdgeInsets.fromLTRB(24.0, 18.0, 24.0, 18.0),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: <Widget>[
          SvgPicture.asset(
            Paths.logo_icon,
            height: 110.0,
            color: AppColors.secondary,
          ),
          const SizedBox(height: 16.0),
          WaterText(
            'Top up your wallet!',
            fontSize: 18.0,
            lineHeight: 1.5,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMessageText() {
    return WaterText(
      'You don’t have enough funds',
      fontSize: 16.0,
      lineHeight: 1.25,
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
      text: 'Top Up',
    );
  }
}
