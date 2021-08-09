import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/shop/shop_bloc.dart';
import 'package:water/ui/screens/home/shop/categories/categories_screen.dart';
import 'package:water/ui/screens/home/shop/products/products_screen.dart';
import 'package:water/ui/shared_widgets/water.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShopBloc, ShopState>(
      listener: (context, state) {
        if (state is CategoriesLoaded) {
          _pageController.jumpToPage(0);
        } else if (state is ProductsLoaded) {
          _pageController.jumpToPage(1);
        }
      },
      child: Column(
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
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: <Widget>[
                CategoriesScreen(),
                ProductsScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
