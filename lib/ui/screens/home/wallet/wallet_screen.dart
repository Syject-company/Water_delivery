import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:water/ui/shared_widgets/button/button.dart';
import 'package:water/ui/shared_widgets/input/form_input.dart';
import 'package:water/ui/shared_widgets/text/text.dart';
import 'package:water/util/masked_input_controller.dart';

class WalletScreen extends StatelessWidget {
  WalletScreen({Key? key}) : super(key: key);

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
          const SizedBox(height: 32.0),
          _buildAddCardForm(),
        ],
      ),
    );
  }

  Widget _buildBalanceText() {
    return WaterText(
      'Wallet balance: AED 0.00',
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
            hintText: 'Enter the amount',
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(width: 12.0),
        WaterText(
          'AED',
          fontSize: 18.0,
        ),
      ],
    );
  }

  Widget _buildAddCardButton() {
    return WaterButton(
      onPressed: () {},
      text: 'Add Card',
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
              const SizedBox(width: 32.0),
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
