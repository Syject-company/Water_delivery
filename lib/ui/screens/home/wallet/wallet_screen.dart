import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/extensions/navigator.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/masked_input_controller.dart';

class WalletScreen extends StatefulWidget {
  WalletScreen({Key? key}) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool _enableAddBalanceForm = false;

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
          children: <Widget>[
            const SizedBox(height: 64.0),
            _buildBalanceText(),
            const SizedBox(height: 32.0),
            PageTransitionSwitcher(
              reverse: !_enableAddBalanceForm,
              layoutBuilder: _defaultLayoutBuilder,
              duration: const Duration(milliseconds: 375),
              transitionBuilder: (child, animation, secondaryAnimation) {
                return SharedAxisTransition(
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.horizontal,
                  fillColor: AppColors.white,
                  child: child,
                );
              },
              child: !_enableAddBalanceForm
                  ? _buildAddBalanceButton()
                  : _AddBalanceForm(),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return WaterAppBar(
      title: WaterText(
        'screen.wallet'.tr(),
        fontSize: 24.0,
        textAlign: TextAlign.center,
      ),
      leading: AppBarBackButton(
        onPressed: () {
          if (_enableAddBalanceForm) {
            setState(() => _enableAddBalanceForm = false);
          } else {
            homeNavigator.pop();
          }
        },
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
    return WaterText(
      'text.wallet_balance'.tr(args: ['0.00']),
      fontSize: 18.0,
      lineHeight: 1.5,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildAddBalanceButton() {
    return WaterButton(
      onPressed: () {
        setState(() => _enableAddBalanceForm = true);
      },
      text: 'button.add_balance'.tr(),
    );
  }
}

class _AddBalanceForm extends StatelessWidget {
  _AddBalanceForm({Key? key}) : super(key: key);

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
    return Column(
      children: <Widget>[
        _buildAmountInput(),
        const SizedBox(height: 32.0),
        _buildTopUpButton(),
        const SizedBox(height: 32.0),
        _buildAddCardForm(),
      ],
    );
  }

  Widget _buildAmountInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 196.0,
          child: WaterFormInput(
            hintText: 'input.enter_amount'.tr(),
          ),
        ),
        const SizedBox(width: 12.0),
        WaterText(
          'text.aed'.tr(args: ['']),
          fontSize: 18.0,
        ),
      ],
    );
  }

  Widget _buildTopUpButton() {
    return WaterButton(
      onPressed: () {},
      text: 'button.top_up'.tr(),
      enabled: false,
    );
  }

  Widget _buildAddCardForm() {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          WaterFormInput(
            controller: _cardNumberInputController,
            labelText: 'Card Number',
            hintText: '**** **** **** 1234',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            labelText: 'Card Holder',
            hintText: 'C. Hemsworth',
          ),
          const SizedBox(height: 16.0),
          Row(
            children: <Widget>[
              Expanded(
                child: WaterFormInput(
                  controller: _expDateInputController,
                  labelText: 'Expiration Date',
                  hintText: 'MM/YY',
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: WaterFormInput(
                  maxLength: 3,
                  labelText: 'CVV',
                  hintText: '123',
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
