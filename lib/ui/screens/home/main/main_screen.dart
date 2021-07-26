import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/main/categories/categories_bloc.dart';
import 'package:water/bloc/home/main/main_bloc.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/screens/home/main/shopping_cart/shopping_cart_screen.dart';
import 'package:water/ui/screens/router.dart';
import 'package:water/ui/shared_widgets/app_bar.dart';
import 'package:water/ui/shared_widgets/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:water/ui/shared_widgets/button/app_bar_back_button.dart';
import 'package:water/ui/shared_widgets/button/app_bar_icon_button.dart';
import 'package:water/ui/shared_widgets/button/app_bar_notification_button.dart';
import 'package:water/ui/shared_widgets/button/circle_button.dart';
import 'package:water/ui/shared_widgets/logo/logo.dart';
import 'package:water/ui/shared_widgets/side_menu.dart';
import 'package:water/ui/shared_widgets/text/text.dart';
import 'package:water/util/session.dart';

import 'categories/categories_screen.dart';
import 'profile/profile_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  final PageController _pageController = PageController(initialPage: 2);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return SideMenu(
          key: _sideMenuKey,
          menu: Menu(),
          child: Scaffold(
            appBar: _buildAppBar(context, state),
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: <Widget>[
                BlocProvider(
                  create: (context) => CategoriesBloc(),
                  child: CategoriesScreen(),
                ),
                ProfileScreen(),
                ShoppingCartScreen(),
              ],
            ),
            bottomNavigationBar: WaterBottomNavigationBar(
              onSelected: (index) => _pageController.jumpToPage(index),
              items: <WaterBottomNavigationBarItem>[
                WaterBottomNavigationBarItem(
                  icon: Icon(AppIcons.bar_categories),
                  selectedIcon: Icon(AppIcons.bar_categories_filled),
                ),
                WaterBottomNavigationBarItem(
                  icon: Icon(AppIcons.bar_profile),
                  selectedIcon: Icon(AppIcons.bar_profile_filled),
                ),
                WaterBottomNavigationBarItem(
                  icon: Icon(AppIcons.bar_shopping_cart),
                  selectedIcon: Icon(AppIcons.bar_shopping_cart_filled),
                ),
                WaterBottomNavigationBarItem(
                  icon: Icon(AppIcons.bar_menu),
                  selectedIcon: Icon(AppIcons.bar_menu_filled),
                  selectable: false,
                  onPressed: () {
                    // SideMenu.of(context).open();
                    _sideMenuKey.currentState!.open();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    MainState state,
  ) {
    final String title;
    switch (state.screen) {
      case Screen.categories:
        title = 'Categories';
        break;
      case Screen.products:
        title = 'Products';
        break;
      case Screen.profile:
        title = 'Profile';
        break;
      case Screen.shoppingCart:
        title = 'Cart';
        break;
      case Screen.menu:
        title = '';
        break;
    }

    return WaterAppBar(
      title: WaterText(
        title,
        fontSize: 24.0,
        textAlign: TextAlign.center,
      ),
      leading: state.screen == Screen.products
          ? AppBarBackButton(onPressed: () {
              context.main.add(ChangeScreen(screen: Screen.categories));
            })
          : null,
      actions: <Widget>[
        AppBarIconButton(
          onPressed: () {},
          icon: AppIcons.whatsapp,
        ),
        AppBarNotificationButton(
          onPressed: () {},
          notificationsCount: 9,
        ),
      ],
    );
  }
}

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
              padding: const EdgeInsets.fromLTRB(0.0, 13.0, 0.0, 26.0),
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  _buildActionButton(
                    onPressed: () {},
                    icon: AppIcons.drop,
                    label: 'Shop Now',
                  ),
                  _buildActionButton(
                    onPressed: () {},
                    icon: AppIcons.wallet,
                    label: 'Wallet',
                  ),
                  _buildActionButton(
                    onPressed: () {},
                    icon: AppIcons.orders,
                    label: 'Orders',
                  ),
                  _buildActionButton(
                    onPressed: () {},
                    icon: AppIcons.subscription,
                    label: 'Subscription',
                  ),
                  _buildActionButton(
                    onPressed: () {},
                    icon: AppIcons.refer_friend,
                    label: 'Refer A Friend',
                  ),
                  _buildActionButton(
                    onPressed: () {},
                    icon: AppIcons.profile,
                    label: 'Profile',
                  ),
                  _buildActionButton(
                    onPressed: () {},
                    icon: AppIcons.support,
                    label: 'Support',
                  ),
                  _buildActionButton(
                    onPressed: () {},
                    icon: AppIcons.terms,
                    label: 'Terms & Conditions',
                  ),
                  _buildActionButton(
                    onPressed: () {},
                    icon: AppIcons.faq,
                    label: 'F.A.Q',
                  ),
                  const SizedBox(height: 13.0),
                  _buildActionButton(
                    onPressed: () {
                      Session.close();
                      Navigator.of(context, rootNavigator: true)
                          .pushReplacementNamed(AppRoutes.auth);
                    },
                    icon: AppIcons.log_out,
                    label: 'Log Out',
                    iconColor: AppColors.secondaryText,
                    labelColor: AppColors.secondaryText,
                  ),
                  const SizedBox(height: 26.0),
                  _buildSocialButtons(),
                ],
              ),
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
          iconSize: 28.0,
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
}
