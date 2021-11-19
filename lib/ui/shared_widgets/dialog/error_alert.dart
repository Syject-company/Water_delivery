import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/ui/shared_widgets/water.dart';

class ErrorAlert extends StatelessWidget {
  const ErrorAlert({
    Key? key,
    this.errorMessage,
    this.actionText,
  }) : super(key: key);

  final String? errorMessage;
  final String? actionText;

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

  Widget _buildTitle(BuildContext context) {
    return Column(
      children: [
        GradientIcon(
          AppIcons.alert,
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
            radius: 1.5,
          ),
        ),
        const SizedBox(height: 16.0),
        WaterText(
          'text.something_went_wrong'.tr(),
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
      errorMessage ?? 'text.try_again'.tr(),
      fontSize: 16.0,
      lineHeight: 1.25,
      fontWeight: FontWeight.w600,
      textAlign: TextAlign.center,
      color: AppColors.primaryText,
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return WaterButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      text: actionText ?? 'button.ok'.tr(),
    );
  }
}
