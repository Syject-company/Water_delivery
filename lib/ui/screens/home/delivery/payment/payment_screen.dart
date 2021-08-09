import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/extensions/navigator.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/screens/home/delivery/delivery_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/masked_input_controller.dart';

class PaymentScreen extends StatefulWidget {
  PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _paymentIndex = 0;
  int _lastPaymentIndex = 0;

  final List<Widget> _paymentForms = <Widget>[
    _CardForm(),
    _WalletForm(),
  ];

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
              reverse: _lastPaymentIndex > _paymentIndex,
              transitionBuilder: (child, animation, secondaryAnimation) {
                return SharedAxisTransition(
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.horizontal,
                  fillColor: AppColors.white,
                  child: child,
                );
              },
              child: _paymentForms[_paymentIndex],
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
      child: WaterRadioGroup<int>(
        onChanged: (index) {
          _lastPaymentIndex = _paymentIndex;
          setState(() => _paymentIndex = index);
        },
        initialValue: 0,
        values: {
          0: 'Credit Card',
          1: 'Wallet',
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
              'text.aed'.tr(args: [0.toStringAsFixed(2)]),
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
    return WaterButton(
      onPressed: () {},
      text: 'Pay',
    );
  }
}

class _CardForm extends StatelessWidget {
  _CardForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildAddCardButton(context),
      ],
    );
  }

  Widget _buildAddCardButton(BuildContext context) {
    return WaterButton(
      onPressed: () {
        _showSelectDialog(context);
      },
      text: 'button.add_card'.tr(),
    );
  }

  Future<void> _showSelectDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return _AddCardDialog();
      },
    );
  }
}

class _AddCardDialog extends StatefulWidget {
  const _AddCardDialog({Key? key}) : super(key: key);

  @override
  _AddCardDialogState createState() => _AddCardDialogState();
}

class _AddCardDialogState extends State<_AddCardDialog> {
  final MaskedInputController _cardNumberInputController =
      MaskedInputController(
    mask: '#### #### #### ####',
    filter: {'#': RegExp('[0-9]')},
  );

  final MaskedInputController _expDateInputController = MaskedInputController(
    mask: '##/##',
    filter: {'#': RegExp('[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0.0,
      titlePadding: const EdgeInsets.fromLTRB(24.0, 18.0, 24.0, 18.0),
      contentPadding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 18.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      title: _buildTitle(),
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildAddCardForm(),
            const SizedBox(height: 32.0),
            _buildAddButton(),
            const SizedBox(height: 8.0),
            _buildCancelButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: WaterText(
        'Add New Card',
        fontSize: 20.0,
        lineHeight: 1.5,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildAddCardForm() {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          WaterFormInput(
            controller: _cardNumberInputController,
            hintText: 'Card Number',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16.0),
          Row(
            children: <Widget>[
              Expanded(
                child: WaterFormInput(
                  controller: _expDateInputController,
                  hintText: 'MM/YY',
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: WaterFormInput(
                  maxLength: 3,
                  hintText: 'CVV',
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return WaterButton(
      onPressed: () {},
      text: 'Add',
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return WaterButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      text: 'Cancel',
      backgroundColor: AppColors.transparent,
      foregroundColor: AppColors.secondaryText,
    );
  }
}

class _WalletForm extends StatelessWidget {
  _WalletForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildBalanceText(),
      ],
    );
  }

  Widget _buildBalanceText() {
    return WaterText(
      'text.wallet_balance'.tr(args: ['0.00']),
      fontSize: 18.0,
      lineHeight: 1.5,
      textAlign: TextAlign.center,
    );
  }
}
