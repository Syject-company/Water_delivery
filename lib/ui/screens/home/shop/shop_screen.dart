import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/navigation/navigation_bloc.dart';
import 'package:water/ui/shared_widgets/carousel_slider/carousel_slider.dart';

import 'categories/categories_screen.dart';
import 'products/products_screen.dart';

class ShopScreen extends StatelessWidget {
  ShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (_, state) {
        Widget screen = const SizedBox.shrink();
        if (state.selectedScreen.name == HomeScreens.shop) {
          screen = const CategoriesScreen();
        } else if (state.selectedScreen.name == HomeScreens.products) {
          screen = const ProductsScreen();
        }

        return Column(
          children: <Widget>[
            CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 1.9,
                viewportFraction: 0.75,
                spaceBetween: 24.0,
              ),
              items: <Widget>[
                Image.asset(
                  'assets/images/banner_1.jpg',
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.high,
                ),
                Image.asset(
                  'assets/images/banner_2.jpg',
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.high,
                ),
              ],
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                switchInCurve: Curves.easeInOutCubic,
                switchOutCurve: Curves.easeInOutCubic,
                child: screen,
              ),
            ),
          ],
        );
      },
    );
  }
}
