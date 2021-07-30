import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/shop/shop_bloc.dart';
import 'package:water/ui/shared_widgets/carousel_slider/carousel_slider.dart';

import 'categories/categories_screen.dart';
import 'products/products_screen.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopBloc, ShopState>(
      builder: (context, state) {
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
              child: Stack(
                children: <Widget>[
                  if (state is CategoriesLoaded) CategoriesScreen(),
                  if (state is ProductsLoaded) ProductsScreen(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
