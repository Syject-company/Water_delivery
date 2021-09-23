import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/ui/shared_widgets/water.dart';

class SuccessfulPaymentAlert extends StatelessWidget {
  const SuccessfulPaymentAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0.0,
      titlePadding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 32.0),
      contentPadding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(19.0),
      ),
      title: _buildTitle(),
      content: Container(
        width: 100.w,
        constraints: BoxConstraints(
          maxWidth: 264.0,
        ),
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

  Widget _buildTitle() {
    return Column(
      children: [
        GradientIcon(
          AppIcons.logo,
          size: 96.0,
          color: AppColors.secondary,
          gradient: RadialGradient(
            colors: [
              AppColors.white,
              AppColors.secondary,
            ],
            stops: [
              0.0,
              1.0,
            ],
            center: Alignment.bottomLeft,
            radius: 3.0,
          ),
        ),
        const SizedBox(height: 16.0),
        WaterText(
          'text.successful_payment'.tr(),
          fontSize: 18.0,
          lineHeight: 1.5,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w800,
          color: AppColors.primaryText,
        ),
      ],
    );
  }

  Widget _buildMessageText() {
    return WaterText(
      'text.thanks_for_order'.tr(),
      fontSize: 16.0,
      lineHeight: 1.25,
      textAlign: TextAlign.center,
      fontWeight: FontWeight.w600,
      color: AppColors.primaryText,
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return WaterButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      text: 'button.ok'.tr(),
    );
  }
}
