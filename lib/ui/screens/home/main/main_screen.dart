import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/main/main_bloc.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/shared_widgets/app_bar.dart';
import 'package:water/ui/shared_widgets/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:water/ui/shared_widgets/button/app_bar_back_button.dart';
import 'package:water/ui/shared_widgets/button/app_bar_icon_button.dart';
import 'package:water/ui/shared_widgets/button/app_bar_notification_button.dart';
import 'package:water/ui/shared_widgets/side_menu.dart';
import 'package:water/ui/shared_widgets/text/text.dart';

import 'cart/cart_screen.dart';
import 'categories/categories_screen.dart';
import 'profile/profile_screen.dart';
import 'widgets/menu.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  final PageController _pageController = PageController(initialPage: 0);

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
                CategoriesScreen(),
                ProfileScreen(),
                CartScreen(),
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
      case Screen.cart:
        title = 'Cart';
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
