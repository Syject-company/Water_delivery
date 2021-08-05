import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/ui/shared_widgets/button/button.dart';
import 'package:water/ui/shared_widgets/input/form_fields.dart';
import 'package:water/ui/shared_widgets/text/text.dart';

class WalletScreen extends StatelessWidget {
  WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 64.0),
          _buildBalanceText(),
          const SizedBox(height: 32.0),
          _buildAmountInput(),
          const SizedBox(height: 32.0),
          _buildAddCardButton(),
        ],
      ),
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

  Widget _buildAmountInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 196.0,
          child: WaterFormInput(
            hintText: 'input.enter_amount'.tr(),
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(width: 12.0),
        WaterText(
          'text.aed'.tr(args: ['']).trim(),
          fontSize: 18.0,
        ),
      ],
    );
  }

  Widget _buildAddCardButton() {
    return WaterButton(
      onPressed: () {},
      text: 'button.add_card'.tr(),
    );
  }
}
