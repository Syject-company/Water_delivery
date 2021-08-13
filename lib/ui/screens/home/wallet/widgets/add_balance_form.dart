import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/bloc/home/wallet/wallet_bloc.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/currency_input_formatter.dart';

class AddBalanceForm extends StatefulWidget {
  AddBalanceForm({Key? key}) : super(key: key);

  @override
  _AddBalanceFormState createState() => _AddBalanceFormState();
}

class _AddBalanceFormState extends State<AddBalanceForm> {
  final GlobalKey<WaterFormInputState> _amountInputKey = GlobalKey();
  final TextEditingController _amountInputController = TextEditingController();

  bool _isValidForm = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAmountInput(),
        const SizedBox(height: 32.0),
        _buildTopUpButton(),
      ],
    );
  }

  Widget _buildAmountInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 196.0,
          child: WaterFormInput(
            key: _amountInputKey,
            controller: _amountInputController,
            hintText: 'input.enter_amount'.tr(),
            onChanged: (amount) {
              if (amount.isNotEmpty) {
                setState(() => _isValidForm = double.parse(amount) > 0.0);
              } else {
                setState(() => _isValidForm = false);
              }
            },
            formatters: [CurrencyInputFormatter()],
            keyboardType: TextInputType.number,
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
      onPressed: () {
        final amount = double.parse(_amountInputKey.currentState!.value);
        context.wallet.add(AddBalance(amount: amount));
      },
      text: 'button.top_up'.tr(),
      enabled: _isValidForm,
    );
  }
}
