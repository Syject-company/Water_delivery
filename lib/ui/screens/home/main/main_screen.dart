import 'package:flutter/material.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/screens/home/main/categories/categories_screen.dart';
import 'package:water/ui/screens/router.dart';
import 'package:water/ui/shared_widgets/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:water/ui/shared_widgets/button/appbar_icon_button.dart';
import 'package:water/ui/shared_widgets/text/label.dart';
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
          CategoriesScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        onSelected: (index) => print(index),
        items: <BottomNavBarItem>[
          BottomNavBarItem(
            icon: Icon(AppIcons.bar_categories),
            selectedIcon: Icon(AppIcons.bar_categories_filled),
          ),
          BottomNavBarItem(
            icon: Icon(AppIcons.bar_profile),
            selectedIcon: Icon(AppIcons.bar_profile_filled),
          ),
          BottomNavBarItem(
            icon: Icon(AppIcons.bar_shopping_cart),
            selectedIcon: Icon(AppIcons.bar_shopping_cart_filled),
          ),
          BottomNavBarItem(
            icon: Icon(AppIcons.bar_menu),
            selectedIcon: Icon(AppIcons.bar_menu_filled),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Label(
        'Categories',
        fontSize: 21.0,
      ),
      actions: <Widget>[
        AppBarIconButton(
          icon: AppIcons.whatsapp,
          onPressed: () {},
          iconSize: 32.0,
        ),
        AppBarIconButton(
          icon: AppIcons.notification,
          onPressed: () {
            Session.close();
            Navigator.of(context, rootNavigator: true)
                .pushReplacementNamed(AppRoutes.auth);
          },
          iconSize: 32.0,
        ),
      ],
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }
}
