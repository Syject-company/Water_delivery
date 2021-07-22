import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/main/categories/categories_bloc.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/screens/home/main/categories/categories_screen.dart';
import 'package:water/ui/screens/router.dart';
import 'package:water/ui/shared_widgets/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:water/ui/shared_widgets/button/appbar_icon_button.dart';
import 'package:water/ui/shared_widgets/button/appbar_notification_button.dart';
import 'package:water/ui/shared_widgets/text/text.dart';
import 'package:water/util/session.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: PageView(
        physics: const BouncingScrollPhysics(),
        controller: _pageController,
        children: <Widget>[
          BlocProvider(
            create: (context) => CategoriesBloc(),
            child: CategoriesScreen(),
          ),
        ],
      ),
      bottomNavigationBar: WaterBottomNavigationBar(
        onSelected: (index) => print(index),
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
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 72.0,
      centerTitle: true,
      title: WaterText(
        'Categories',
        fontSize: 24.0,
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        AppBarIconButton(
          onPressed: () {},
          icon: AppIcons.whatsapp,
        ),
        AppBarNotificationButton(
          onPressed: () {
            Session.close();
            Navigator.of(context, rootNavigator: true)
                .pushReplacementNamed(AppRoutes.auth);
          },
          notificationsCount: 9,
        ),
      ],
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }
}
