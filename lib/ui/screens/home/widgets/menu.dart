import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/bloc/home/auth/auth_bloc.dart';
import 'package:water/bloc/home/navigation/navigation_bloc.dart';
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
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(0.0, 13.0, 0.0, 0.0),
              physics: const BouncingScrollPhysics(),
              child: _buildActionButtons(context),
            ),
          ),
          _buildSocialButtons(),
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
      children: [
        if (!Session.isAuthenticated)
          _buildActionButton(
            onPressed: () {
              homeNavigator.pushNamed(HomeRoutes.auth);
            },
            icon: AppIcons.login,
            label: 'side_menu.login'.tr(),
          ),
        _buildActionButton(
          onPressed: () {
            _navigateTo(context, Screen.home);
          },
          icon: AppIcons.drop,
          label: 'side_menu.shop_now'.tr(),
        ),
        if (Session.isAuthenticated)
          _buildActionButton(
            onPressed: () {
              homeNavigator.pushNamed(HomeRoutes.wallet);
            },
            icon: AppIcons.wallet,
            label: 'side_menu.wallet'.tr(),
          ),
        if (Session.isAuthenticated)
          _buildActionButton(
            onPressed: () {
              homeNavigator.pushNamed(HomeRoutes.orders);
            },
            icon: AppIcons.orders,
            label: 'side_menu.orders'.tr(),
          ),
        if (Session.isAuthenticated)
          _buildActionButton(
            onPressed: () {
              homeNavigator.pushNamed(HomeRoutes.subscriptions);
            },
            icon: AppIcons.subscription,
            label: 'side_menu.subscriptions'.tr(),
          ),
        if (Session.isAuthenticated)
          _buildActionButton(
            onPressed: () {
              _navigateTo(context, Screen.profile);
            },
            icon: AppIcons.profile,
            label: 'side_menu.profile'.tr(),
          ),
        _buildActionButton(
          onPressed: () {
            homeNavigator.pushNamed(HomeRoutes.support);
          },
          icon: AppIcons.support,
          label: 'side_menu.support'.tr(),
        ),
        _buildActionButton(
          onPressed: () {
            homeNavigator.pushNamed(HomeRoutes.terms);
          },
          icon: AppIcons.terms,
          label: 'side_menu.terms'.tr(),
        ),
        _buildActionButton(
          onPressed: () {
            homeNavigator.pushNamed(HomeRoutes.faq);
          },
          icon: AppIcons.faq,
          label: 'side_menu.faq'.tr(),
        ),
        if (Session.isAuthenticated)
          _buildActionButton(
            onPressed: () {
              context.auth.add(Logout());
            },
            icon: AppIcons.logout,
            label: 'button.logout'.tr(),
            iconColor: AppColors.secondaryText,
            labelColor: AppColors.secondaryText,
          ).withPadding(0.0, 13.0, 0.0, 0.0),
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
      child: Row(
        children: [
          Icon(
            icon,
            size: 32.0,
            color: iconColor,
          ),
          const SizedBox(width: 26.0),
          Flexible(
            child: WaterText(
              label,
              maxLines: 1,
              fontSize: 18.0,
              lineHeight: 1.75,
              color: labelColor,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ).withPadding(56.0, 13.0, 26.0, 13.0),
      behavior: HitTestBehavior.opaque,
    );
  }

  Widget _buildSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WaterSocialButton(
          onPressed: () {},
          icon: AppIcons.facebook,
        ),
        const SizedBox(width: 18.0),
        WaterSocialButton(
          onPressed: () {},
          icon: AppIcons.instagram,
        ),
        const SizedBox(width: 18.0),
        WaterSocialButton(
          onPressed: () {},
          icon: AppIcons.twitter,
        ),
      ],
    ).withPaddingAll(26.0);
  }

  void _navigateTo(BuildContext context, Screen screen) {
    context.navigation.add(NavigateTo(screen: screen));
    SideMenu.of(context).close();
  }
}
