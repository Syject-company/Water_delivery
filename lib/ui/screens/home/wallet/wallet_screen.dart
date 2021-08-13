import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/wallet/wallet_bloc.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/extensions/navigator.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';

import 'widgets/add_balance_form.dart';

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
          children: [
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
                  : AddBalanceForm(),
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
      actions: [
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
        return WaterText(
          'text.wallet_balance'.tr(args: [state.balance.toStringAsFixed(2)]),
          fontSize: 18.0,
          lineHeight: 1.5,
          textAlign: TextAlign.center,
        );
      },
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
