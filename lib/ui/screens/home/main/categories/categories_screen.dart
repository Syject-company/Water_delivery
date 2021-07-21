import 'package:flutter/material.dart';
import 'package:water/ui/shared_widgets/carousel_slider/carousel_slider.dart';

import 'pages/categories_page.dart';
import 'pages/products_page.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({Key? key}) : super(key: key);

  final PageController _categoriesPageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 320 / 168,
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
          child: PageView(
            controller: _categoriesPageController,
            children: [
              CategoriesPage(),
              ProductsPage(),
            ],
          ),
        ),
      ],
    );
  }
}
