import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';

class TopUpWalletDialog extends StatelessWidget {
  const TopUpWalletDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0.0,
      titlePadding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 32.0),
      contentPadding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(19.0),
      ),
      title: _buildTitle(context),
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildMessageText(),
            const SizedBox(height: 32.0),
            _buildAddButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        PositionedDirectional(
          top: 0.0,
          end: 0.0,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              AppIcons.close,
              size: 32.0,
              color: AppColors.secondaryText,
            ),
            behavior: HitTestBehavior.opaque,
          ),
        ),
        Column(
          children: [
            Icon(
              AppIcons.alert,
              size: 96.0,
              color: AppColors.secondary,
            ),
            const SizedBox(height: 16.0),
            WaterText(
              'text.top_up_wallet'.tr(),
              fontSize: 18.0,
              lineHeight: 1.5,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMessageText() {
    return WaterText(
      'text.not_enough_money'.tr(),
      fontSize: 16.0,
      lineHeight: 1.25,
      fontWeight: FontWeight.w500,
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
      text: 'button.top_up'.tr(),
    );
  }
}
