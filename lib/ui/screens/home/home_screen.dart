import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/navigation/navigation_bloc.dart';
import 'package:water/bloc/home/shop/shop_bloc.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/shared_widgets/app_bar.dart';
import 'package:water/ui/shared_widgets/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:water/ui/shared_widgets/button/app_bar_back_button.dart';
import 'package:water/ui/shared_widgets/button/app_bar_icon_button.dart';
import 'package:water/ui/shared_widgets/button/app_bar_notification_button.dart';
import 'package:water/ui/shared_widgets/side_menu.dart';
import 'package:water/ui/shared_widgets/text/animated_text.dart';

import 'cart/cart_screen.dart';
import 'profile/profile_screen.dart';
import 'shop/shop_screen.dart';
import 'widgets/menu.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final GlobalKey<AnimatedWaterTextState> _titleTextKey = GlobalKey();
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  final PageController _screenController = PageController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: SideMenu(
        key: _sideMenuKey,
        menu: Menu(),
        child: Scaffold(
          appBar: _buildAppBar(context),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _screenController,
            children: <Widget>[
              ShopScreen(),
              ProfileScreen(),
              CartScreen(),
            ],
          ),
          bottomNavigationBar: BlocConsumer<NavigationBloc, NavigationState>(
            listener: (_, state) {
              _screenController.jumpToPage(state.selectedScreen.index);
            },
            builder: (_, state) {
              return WaterBottomNavigationBar(
                selectedIndex: state.selectedScreen.index,
                items: <WaterBottomNavigationBarItem>[
                  WaterBottomNavigationBarItem(
                    icon: Icon(AppIcons.bar_shop),
                    selectedIcon: Icon(AppIcons.bar_shop_filled),
                    onPressed: () {
                      context.navigation.add(
                        NavigateTo(name: HomeScreens.shop),
                      );
                      context.shop.add(LoadCategories());
                    },
                  ),
                  WaterBottomNavigationBarItem(
                    icon: Icon(AppIcons.bar_profile),
                    selectedIcon: Icon(AppIcons.bar_profile_filled),
                    onPressed: () => context.navigation.add(
                      NavigateTo(name: HomeScreens.profile),
                    ),
                  ),
                  WaterBottomNavigationBarItem(
                    icon: Icon(AppIcons.bar_shopping_cart),
                    selectedIcon: Icon(AppIcons.bar_shopping_cart_filled),
                    onPressed: () => context.navigation.add(
                      NavigateTo(name: HomeScreens.cart),
                    ),
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
              );
            },
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight),
      child: BlocConsumer<NavigationBloc, NavigationState>(
        listener: (_, state) {
          _titleTextKey.currentState!.setNewValue(state.selectedScreen.title);
        },
        builder: (_, state) {
          return WaterAppBar(
            title: AnimatedWaterText(
              state.selectedScreen.title,
              key: _titleTextKey,
              fontSize: 24.0,
              lineHeight: 2.0,
              textAlign: TextAlign.center,
            ),
            leading: state.selectedScreen.name == HomeScreens.products
                ? AppBarBackButton(onPressed: () {
                    context.navigation.add(NavigateTo(name: HomeScreens.shop));
                    context.shop.add(LoadCategories());
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
        },
      ),
    );
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    final selectedScreen = context.navigation.state.selectedScreen;

    if (selectedScreen.name != HomeScreens.shop) {
      context.navigation.add(NavigateTo(name: HomeScreens.shop));
      context.shop.add(LoadCategories());
      return false;
    }

    return true;
  }
}
