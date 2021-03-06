import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/wallet/wallet_bloc.dart';
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
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return WaterAppBar(
      title: WaterText(
        'screen.wallet'.tr(),
        fontSize: 24.0,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w800,
        color: AppColors.primaryText,
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
        AppBarWhatsappButton(),
        AppBarNotificationButton(),
      ],
    );
  }

  Widget _buildBody() {
    return SizedBox.expand(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        physics: const BouncingScrollPhysics(),
        child: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: isMobile ? 100.w : 50.w,
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
        ),
      ),
    );
  }

  Widget _buildBalanceText() {
    return BlocBuilder<WalletBloc, WalletState>(
      buildWhen: (_, state) {
        return state is WalletLoaded;
      },
      builder: (_, state) {
        if (state is WalletLoaded) {
          return WaterText(
            'text.wallet_balance'.tr(args: [
              state.balance.toStringAsFixed(2),
            ]),
            fontSize: 18.0,
            lineHeight: 1.5,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryText,
          );
        }
        return const SizedBox.shrink();
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
