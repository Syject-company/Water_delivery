import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/bloc/home/navigation/navigation_bloc.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/extensions/navigator.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/screens/home/router.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/session.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(0.0, 13.0, 0.0, 26.0),
              physics: const BouncingScrollPhysics(),
              child: _buildActionButtons(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 148.0,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFD2F4FF),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: const WaterLogo(
          labelWidthFactor: 2.25,
          showIcon: false,
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildActionButton(
          onPressed: () {
            _navigateTo(context, Screen.shop);
          },
          icon: AppIcons.drop,
          label: 'side_menu.shop_now'.tr(),
        ),
        _buildActionButton(
          onPressed: () {
            homeNavigator.pushNamed(HomeRoutes.wallet);
          },
          icon: AppIcons.wallet,
          label: 'side_menu.wallet'.tr(),
        ),
        _buildActionButton(
          onPressed: () {
            homeNavigator.pushNamed(HomeRoutes.orders);
          },
          icon: AppIcons.orders,
          label: 'side_menu.orders'.tr(),
        ),
        _buildActionButton(
          onPressed: () {},
          icon: AppIcons.subscription,
          label: 'side_menu.subscriptions'.tr(),
        ),
        _buildActionButton(
          onPressed: () {},
          icon: AppIcons.refer_friend,
          label: 'side_menu.refer_friend'.tr(),
        ),
        _buildActionButton(
          onPressed: () {
            _navigateTo(context, Screen.profile);
          },
          icon: AppIcons.profile,
          label: 'side_menu.profile'.tr(),
        ),
        _buildActionButton(
          onPressed: () {},
          icon: AppIcons.support,
          label: 'side_menu.support'.tr(),
        ),
        _buildActionButton(
          onPressed: () {},
          icon: AppIcons.terms,
          label: 'side_menu.terms'.tr(),
        ),
        _buildActionButton(
          onPressed: () {},
          icon: AppIcons.faq,
          label: 'side_menu.faq'.tr(),
        ),
        const SizedBox(height: 13.0),
        _buildActionButton(
          onPressed: () {
            Session.invalidate(context);
          },
          icon: AppIcons.log_out,
          label: 'button.logout'.tr(),
          iconColor: AppColors.secondaryText,
          labelColor: AppColors.secondaryText,
        ),
        const SizedBox(height: 26.0),
        _buildSocialButtons(),
      ],
    );
  }

  Widget _buildActionButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    Color iconColor = AppColors.primary,
    Color labelColor = AppColors.primaryText,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(56.0, 13.0, 24.0, 13.0),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              size: 32.0,
              color: iconColor,
            ),
            const SizedBox(width: 28.0),
            Flexible(
              child: WaterText(
                label,
                maxLines: 1,
                fontSize: 20.0,
                lineHeight: 1.75,
                color: labelColor,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      behavior: HitTestBehavior.opaque,
    );
  }

  Widget _buildSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        WaterCircleButton(
          onPressed: () {},
          icon: AppIcons.facebook,
          iconSize: 32.0,
        ),
        const SizedBox(width: 18.0),
        WaterCircleButton(
          onPressed: () {},
          icon: AppIcons.instagram,
          iconSize: 32.0,
        ),
        const SizedBox(width: 18.0),
        WaterCircleButton(
          onPressed: () {},
          icon: AppIcons.twitter,
          iconSize: 32.0,
        ),
      ],
    );
  }

  void _navigateTo(BuildContext context, Screen screen) {
    context.navigation.add(NavigateTo(screen: screen));
    SideMenu.of(context).close();
  }
}
