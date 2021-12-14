import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:water/bloc/home/cart/cart_bloc.dart';
import 'package:water/bloc/home/navigation/navigation_bloc.dart';
import 'package:water/bloc/home/notifications/notifications_bloc.dart';
import 'package:water/bloc/home/profile/profile_bloc.dart';
import 'package:water/bloc/home/shopping/banners/banners_bloc.dart';
import 'package:water/bloc/home/shopping/categories/categories_bloc.dart';
import 'package:water/bloc/home/shopping/products/products_bloc.dart';
import 'package:water/bloc/home/shopping/shopping_bloc.dart';
import 'package:water/ui/constants/paths.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/keep_alive.dart';
import 'package:water/util/local_notification.dart';
import 'package:water/util/local_storage.dart';
import 'package:water/util/localization.dart';
import 'package:water/util/session.dart';

import 'cart/cart_screen.dart';
import 'profile/profile_screen.dart';
import 'shopping/shopping_screen.dart';
import 'widgets/menu.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey();
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _listenNotifications();
  }

  void _listenNotifications() {
    FirebaseMessaging.onMessage.listen((message) async {
      await LocalStorage.ensureInitialized();

      LocalNotifications.showNotification(
        id: message.hashCode,
        body: message.data[LocalStorage.locale],
      );

      context.notifications.add(
        LoadNotifications(language: Localization.currentLanguage(context)),
      );
    });
    FirebaseMessaging.onMessageOpenedApp.listen((_) {
      context.notifications.add(
        LoadNotifications(language: Localization.currentLanguage(context)),
      );
    });
  }

  @override
  void didUpdateWidget(HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    final language = Localization.currentLanguage(context);
    final shoppingState = context.shopping.state;
    final categoriesState = context.categories.state;
    final productsState = context.products.state;

    if (categoriesState is CategoriesLoaded) {
      context.categories.add(
        LoadCategories(
          language: language,
          navigate: false,
        ),
      );
      if (shoppingState is ShoppingProducts &&
          productsState is ProductsLoaded) {
        context.products.add(
          LoadProducts(
            categoryId: productsState.categoryId,
            language: language,
            navigate: false,
          ),
        );
      }
    }
    context.banners.add(
      LoadBanners(language: language),
    );
    context.profile.add(
      UpdateProfile(),
    );
    context.notifications.add(
      LoadNotifications(language: language),
    );
    context.cart.add(
      LoadCart(language: language),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SideMenu(
        key: _sideMenuKey,
        menu: Menu(),
        child: Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(),
          bottomNavigationBar: _buildBottomNavigationBar(),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight),
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (_, state) {
          Widget? leading;
          if (state is Products) {
            leading = AppBarBackButton(
              onPressed: () {
                context.navigation.add(
                  BackPressed(),
                );
              },
            );
          }

          return WaterAppBar(
            title: WaterText(
              state.title.tr(),
              fontSize: 24.0,
              fontWeight: FontWeight.w800,
              textAlign: TextAlign.center,
              color: AppColors.primaryText,
            ),
            leading: leading,
            actions: [
              AppBarWhatsappButton(),
              if (Session.isAuthenticated) AppBarNotificationButton(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: [
        KeepAliveChild(child: ShoppingScreen()),
        KeepAliveChild(child: ProfileScreen()),
        KeepAliveChild(child: CartScreen()),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return BlocConsumer<NavigationBloc, NavigationState>(
      listener: (_, state) {
        _pageController.jumpToPage(state.index);
      },
      builder: (_, state) {
        return WaterBottomNavigationBar(
          selectedIndex: state.index,
          items: [
            WaterBottomNavigationBarItem(
              icon: SvgPicture.asset(Paths.logo_label_colored)
                  .withPaddingAll(6.0),
              selectedIcon:
                  SvgPicture.asset(Paths.logo_label_white).withPaddingAll(6.0),
              onPressed: () {
                context.navigation.add(
                  NavigateTo(screen: Screen.home),
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
              enabled: Session.isAuthenticated,
            ),
            WaterBottomNavigationBarItem(
              icon: Icon(AppIcons.bar_cart),
              selectedIcon: Icon(AppIcons.bar_cart_filled),
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
    );
  }

  Future<bool> _onBackPressed() async {
    if (_sideMenuKey.currentState!.isOpened) {
      _sideMenuKey.currentState!.close();
      return false;
    }

    if (context.navigation.state is! Home) {
      context.navigation.add(
        NavigateTo(screen: Screen.home),
      );
      return false;
    }

    if (context.navigation.state is Products) {
      context.navigation.add(
        BackPressed(),
      );
      return false;
    }

    return true;
  }
}
