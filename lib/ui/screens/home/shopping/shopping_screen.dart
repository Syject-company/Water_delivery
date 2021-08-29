import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/navigation/navigation_bloc.dart';
import 'package:water/bloc/home/shopping/banners/banners_bloc.dart';
import 'package:water/bloc/home/shopping/categories/categories_bloc.dart';
import 'package:water/bloc/home/shopping/products/products_bloc.dart';
import 'package:water/bloc/home/shopping/shopping_bloc.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/localization.dart';

import 'categories/categories_screen.dart';
import 'products/products_screen.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({Key? key}) : super(key: key);

  @override
  _ShoppingScreenState createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  final List<Widget> _pages = [
    CategoriesScreen(),
    ProductsScreen(),
  ];

  int _pageIndex = 0;

  @override
  void didUpdateWidget(ShoppingScreen oldWidget) {
    final shoppingState = context.shopping.state;
    final categoriesState = context.categories.state;
    final productsState = context.products.state;

    if (categoriesState is CategoriesLoaded) {
      context.categories.add(
        LoadCategories(
          language: Localization.currentLanguage(context),
          navigate: false,
        ),
      );
      if (shoppingState is ShoppingProducts &&
          productsState is ProductsLoaded) {
        context.products.add(
          LoadProducts(
            categoryId: productsState.categoryId,
            language: Localization.currentLanguage(context),
            navigate: false,
          ),
        );
      }
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<BannersBloc, BannersState>(
          builder: (_, state) {
            if (state is BannersLoaded) {
              return CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 1.9,
                  viewportFraction: 0.75,
                  spaceBetween: 24.0,
                ),
                items: state.banners.map((banner) {
                  return CachedNetworkImage(
                    imageUrl: banner.image,
                    fit: BoxFit.fill,
                  );
                }).toList(),
              );
            }
            return SizedBox.shrink();
          },
        ),
        BlocBuilder<NavigationBloc, NavigationState>(
          buildWhen: (previousState, state) {
            return state is Home;
          },
          builder: (context, state) {
            int index = 0;
            if (state is Categories) {
              index = 0;
            } else if (state is Products) {
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
