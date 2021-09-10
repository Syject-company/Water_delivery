import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/session.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({Key? key}) : super(key: key);

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
        'screen.terms'.tr(),
        maxLines: 2,
        fontSize: 24.0,
        lineHeight: 2.0,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w800,
        color: AppColors.primaryText,
      ).withPadding(16.0, 0.0, 0.0, 0.0),
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
        if (Session.isAuthenticated) AppBarNotificationButton(),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle('Lorem ipsum dolor sit amet'),
          const SizedBox(height: 8.0),
          _buildContent(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
            'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
            'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. '
            'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. '
            'Excepteur sint occaecat cupidatat non proident, '
            'sunt in culpa qui officia deserunt mollit anim id est laborum',
          ),
          const SizedBox(height: 32.0),
          _buildTitle('Lorem ipsum dolor sit amet'),
          const SizedBox(height: 8.0),
          _buildContent(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
            'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
            'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi '
            'ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit '
            'in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur '
            'sint occaecat cupidatat non.  Duis aute irure dolor in reprehenderit in '
            'voluptate velit esse cillum dolore eu fugiat nulla pariatur. '
            'Excepteur sint occaecat cupidatat non '
            'Duis aute irure dolor in reprehenderit in voluptate velit esse '
            'cillum dolore eu fugiat nulla pariatur.',
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(String title) {
    return WaterText(
      title,
      fontSize: 18.0,
      lineHeight: 1.75,
      fontWeight: FontWeight.w700,
      color: AppColors.primaryText,
    );
  }

  Widget _buildContent(String content) {
    return WaterText(
      content,
      fontSize: 15.0,
      lineHeight: 1.75,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryText,
    );
  }
}
