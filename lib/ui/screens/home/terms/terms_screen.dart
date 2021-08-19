import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/ui/extensions/navigator.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({Key? key}) : super(key: key);

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
        'screen.terms'.tr(),
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
    );
  }

  Widget _buildTitle(String title) {
    return WaterText(
      title,
      fontSize: 18.0,
      lineHeight: 1.75,
      fontWeight: FontWeight.w700,
    );
  }

  Widget _buildContent(String content) {
    return WaterText(
      content,
      fontSize: 15.0,
      lineHeight: 1.75,
      fontWeight: FontWeight.w400,
    );
  }
}
