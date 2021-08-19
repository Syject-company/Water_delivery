import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/extensions/navigator.dart';
import 'package:water/ui/extensions/widget.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        physics: const BouncingScrollPhysics(),
        child: _buildBody(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return WaterAppBar(
      title: WaterText(
        'screen.support'.tr(),
        fontSize: 24.0,
        maxLines: 2,
        lineHeight: 2.0,
        textAlign: TextAlign.center,
      ),
      leading: AppBarBackButton(
        onPressed: () {
          homeNavigator.pop();
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

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCredentialsForm(),
        const SizedBox(height: 24.0),
        _buildMessageForm(),
        const SizedBox(height: 24.0),
        _buildSendButton(),
        const SizedBox(height: 16.0),
        _buildCallButton()
      ],
    );
  }

  Widget _buildCredentialsForm() {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WaterText(
            'text.your_credentials'.tr(),
            fontSize: 18.0,
            lineHeight: 1.75,
          ).withPadding(24.0, 0.0, 0.0, 0.0),
          const SizedBox(height: 24.0),
          WaterFormInput(
            hintText: 'input.your_name'.tr(),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            hintText: 'input.your_email'.tr(),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            hintText: 'input.your_phone'.tr(),
            keyboardType: TextInputType.text,
          ),
        ],
      ),
    );
  }

  Widget _buildMessageForm() {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WaterText(
            'text.type_your_message'.tr(),
            fontSize: 18.0,
            lineHeight: 1.75,
          ).withPadding(24.0, 0.0, 0.0, 0.0),
          const SizedBox(height: 24.0),
          WaterFormInput(
            hintText: 'input.your_message'.tr(),
            keyboardType: TextInputType.multiline,
            maxLines: 5,
          ),
        ],
      ),
    );
  }

  Widget _buildSendButton() {
    return WaterButton(
      onPressed: () {},
      text: 'button.send'.tr(),
    );
  }

  Widget _buildCallButton() {
    return WaterButton(
      onPressed: () {},
      text: 'button.click_to_call'.tr(),
      backgroundColor: AppColors.secondary,
      foregroundColor: AppColors.primary,
    );
  }
}
