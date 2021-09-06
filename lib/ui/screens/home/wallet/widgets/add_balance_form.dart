import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/profile/profile_bloc.dart';
import 'package:water/bloc/home/wallet/wallet_bloc.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/screens/home/wallet/top_up/wallet_top_up_screen.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/currency_input_formatter.dart';
import 'package:water/util/slide_with_fade_page_route.dart';

class AddBalanceForm extends StatefulWidget {
  AddBalanceForm({Key? key}) : super(key: key);

  @override
  _AddBalanceFormState createState() => _AddBalanceFormState();
}

class _AddBalanceFormState extends State<AddBalanceForm> {
  final TextEditingController _amountController = TextEditingController();

  bool _isValidForm = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<WalletBloc, WalletState>(
      listener: (_, state) async {
        if (state is WalletTopUp) {
          FocusScope.of(context).unfocus();

          await homeNavigator.push<bool>(
            SlideWithFadePageRoute(
              builder: (_) => WalletTopUpScreen(url: state.url),
            ),
          );

          setState(() => _isValidForm = false);
          _amountController.clear();
          context.profile.add(
            LoadProfile(),
          );
        }
      },
      child: Column(
        children: [
          _buildAmountInput(),
          const SizedBox(height: 32.0),
          _buildTopUpButton(),
        ],
      ),
    );
  }

  Widget _buildAmountInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 180.0,
          child: WaterFormInput(
            controller: _amountController,
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
            textAlign: TextAlign.center,
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
        final amount = double.parse(_amountController.text);

        context.wallet.add(
          AddBalance(amount: amount),
        );
      },
      text: 'button.top_up'.tr(),
      enabled: _isValidForm,
    );
  }
}
