import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/shop/shop_bloc.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/screens/home/shop/categories/categories_screen.dart';
import 'package:water/ui/screens/home/shop/products/products_screen.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/localization.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final List<Widget> _pages = [
    CategoriesScreen(),
    ProductsScreen(),
  ];

  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.shop.add(
        LoadCategories(
          language: Localization.currentLanguage(context),
        ),
      );
    });
  }

  @override
  void didUpdateWidget(ShopScreen oldWidget) {
    final state = context.shop.state;

    if (state is CategoriesLoaded) {
      context.shop.add(
        LoadCategories(
          language: Localization.currentLanguage(context),
        ),
      );
    } else if (state is ProductsLoading) {
      context.shop.add(
        LoadProducts(
          categoryId: (state as ProductsLoaded).categoryId,
          language: Localization.currentLanguage(context),
        ),
      );
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 1.9,
            viewportFraction: 0.75,
            spaceBetween: 24.0,
          ),
          items: [
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
        BlocBuilder<ShopBloc, ShopState>(
          buildWhen: (previousState, state) {
            return state is CategoriesLoading || state is ProductsLoading;
          },
          builder: (context, state) {
            int index = 0;
            if (state is CategoriesLoading) {
              index = 0;
            } else if (state is ProductsLoading) {
              index = 1;
            }

            return Expanded(
              child: PageTransitionSwitcher(
                reverse: _pageIndex > index,
                transitionBuilder: (child, animation, secondaryAnimation) {
                  return SharedAxisTransition(
                    animation: animation,
                    secondaryAnimation: secondaryAnimation,
                    transitionType: SharedAxisTransitionType.horizontal,
                    fillColor: AppColors.white,
                    child: child,
                  );
                },
                child: _pages[(_pageIndex = index)],
              ),
            );
          },
        ),
      ],
    );
  }
}
