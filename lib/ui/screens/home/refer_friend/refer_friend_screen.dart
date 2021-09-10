import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';

class ReferFriendScreen extends StatelessWidget {
  const ReferFriendScreen({Key? key}) : super(key: key);

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
        'screen.refer_friend'.tr(),
        fontSize: 24.0,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w800,
        color: AppColors.primaryText,
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          _buildHint(
            icon: AppIcons.share,
            content: 'text.share_referral_code'.tr(),
          ),
          const SizedBox(height: 24.0),
          _buildHint(
            icon: AppIcons.group,
            content: 'text.first_register'.tr(),
          ),
          const SizedBox(height: 24.0),
          _buildHint(
            icon: AppIcons.gift,
            content: 'text.wallet_bonus'.tr(),
          ),
          const SizedBox(height: 64.0),
          _buildCodeInput(),
          const SizedBox(height: 24.0),
          _buildShareButton(),
        ],
      ),
    );
  }

  Widget _buildHint({
    required IconData icon,
    required String content,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 36.0,
          color: AppColors.primary,
        ).withPaddingAll(12.0),
        const SizedBox(width: 16.0),
        Expanded(
          child: WaterText(
            content,
            fontSize: 16.0,
            lineHeight: 1.5,
            fontWeight: FontWeight.w500,
            color: AppColors.secondaryText,
          ),
        ),
      ],
    );
  }

  Widget _buildCodeInput() {
    return WaterFormInput(
      hintText: 'input.code'.tr(),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildShareButton() {
    return WaterButton(
      onPressed: () {},
      text: 'button.share'.tr(),
    );
  }
}
