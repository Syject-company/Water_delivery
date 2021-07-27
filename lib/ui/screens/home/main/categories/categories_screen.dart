import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/main/main_bloc.dart';
import 'package:water/ui/screens/home/main/categories/pages/products_page.dart';
import 'package:water/ui/shared_widgets/carousel_slider/carousel_slider.dart';

import 'pages/categories_page.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (_, state) {
        Widget screen = const SizedBox.shrink();
        if (state.screen == Screen.categories) {
          screen = const CategoriesPage();
        } else if (state.screen == Screen.products) {
          screen = const ProductsPage();
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
                Image.asset(
                  'assets/images/shrink_wrap_500ml_v1.png',
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.high,
                ),
              ],
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 375),
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
