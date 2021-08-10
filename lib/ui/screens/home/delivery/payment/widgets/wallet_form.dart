import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/wallet/wallet_bloc.dart';
import 'package:water/ui/shared_widgets/water.dart';

class WalletForm extends StatelessWidget {
  WalletForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildBalanceText(),
      ],
    );
  }

  Widget _buildBalanceText() {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        return WaterText(
          'text.wallet_balance'.tr(args: [state.balance.toStringAsFixed(2)]),
          fontSize: 18.0,
          lineHeight: 1.5,
          textAlign: TextAlign.center,
        );
      },
    );
  }
}
