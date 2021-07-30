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
import 'notifications/notifications_screen.dart';
import 'profile/profile_screen.dart';
import 'shop/shop_screen.dart';
import 'wallet/wallet_screen.dart';
import 'widgets/menu.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final GlobalKey<AnimatedWaterTextState> _titleTextKey = GlobalKey();
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: SideMenu(
        key: _sideMenuKey,
        menu: Menu(),
        child: Scaffold(
          appBar: _buildAppBar(context),
          body: BlocBuilder<NavigationBloc, NavigationState>(
            builder: (context, state) {
              return Stack(
                children: <Widget>[
                  if (state is Shop) ShopScreen(),
                  if (state is Profile) ProfileScreen(),
                  if (state is Cart) CartScreen(),
                  if (state is Wallet) WalletScreen(),
                  if (state is Notifications) NotificationsScreen(),
                ],
              );
            },
          ),
          bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
            builder: (_, state) {
              int? selectedIndex;
              if (state is Shop) {
                selectedIndex = 0;
              } else if (state is Profile) {
                selectedIndex = 1;
              } else if (state is Cart) {
                selectedIndex = 2;
              }

              return WaterBottomNavigationBar(
                selectedIndex: selectedIndex,
                items: <WaterBottomNavigationBarItem>[
                  WaterBottomNavigationBarItem(
                    icon: Icon(AppIcons.bar_shop),
                    selectedIcon: Icon(AppIcons.bar_shop_filled),
                    onPressed: () {
                      context.navigation.add(
                        NavigateTo(screen: Screen.shop),
                      );
                    },
                  ),
                  WaterBottomNavigationBarItem(
                    icon: Icon(AppIcons.bar_profile),
                    selectedIcon: Icon(AppIcons.bar_profile_filled),
                    onPressed: () {
                      context.navigation.add(
                        NavigateTo(screen: Screen.profile),
                      );
                    },
                  ),
                  WaterBottomNavigationBarItem(
                    icon: Icon(AppIcons.bar_shopping_cart),
                    selectedIcon: Icon(AppIcons.bar_shopping_cart_filled),
                    onPressed: () {
                      context.navigation.add(
                        NavigateTo(screen: Screen.cart),
                      );
                    },
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
          _titleTextKey.currentState!.setNewValue(state.title);
        },
        builder: (_, state) {
          Widget? leading;
          if (state is ShopProducts) {
            leading = AppBarBackButton(
              onPressed: () {
                context.shop.add(LoadCategories());
              },
            );
          }

          return WaterAppBar(
            title: AnimatedWaterText(
              state.title,
              key: _titleTextKey,
              fontSize: 24.0,
              lineHeight: 2.0,
              textAlign: TextAlign.center,
            ),
            leading: leading,
            actions: <Widget>[
              AppBarIconButton(
                onPressed: () {},
                icon: AppIcons.whatsapp,
              ),
              AppBarNotificationButton(),
            ],
          );
        },
      ),
    );
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    if (context.navigation.state is! Shop) {
      context.navigation.add(NavigateTo(screen: Screen.shop));
      return false;
    }

    if (context.navigation.state is ShopProducts) {
      context.shop.add(LoadCategories());
      return false;
    }

    return true;
  }
}
