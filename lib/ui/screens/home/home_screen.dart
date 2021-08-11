import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/navigation/navigation_bloc.dart';
import 'package:water/bloc/home/shop/shop_bloc.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/keep_alive.dart';

import 'cart/cart_screen.dart';
import 'profile/profile_screen.dart';
import 'shop/shop_screen.dart';
import 'widgets/menu.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  final PageController _pageController = PageController();

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
            controller: _pageController,
            children: <Widget>[
              KeepAliveChild(child: ShopScreen()),
              KeepAliveChild(child: ProfileScreen()),
              KeepAliveChild(child: CartScreen()),
            ],
          ),
          bottomNavigationBar: BlocConsumer<NavigationBloc, NavigationState>(
            listener: (context, state) {
              _pageController.jumpToPage(state.index);
            },
            builder: (context, state) {
              return WaterBottomNavigationBar(
                selectedIndex: state.index,
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
      child: BlocBuilder<NavigationBloc, NavigationState>(
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
            title: WaterText(
              state.title.tr(),
              fontSize: 24.0,
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
    if (_sideMenuKey.currentState!.isOpened) {
      _sideMenuKey.currentState!.close();
      return false;
    }

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
