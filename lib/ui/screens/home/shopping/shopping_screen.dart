import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/navigation/navigation_bloc.dart';
import 'package:water/ui/shared_widgets/shimmer.dart';
import 'package:water/ui/shared_widgets/water.dart';

import 'categories/categories_screen.dart';
import 'products/products_screen.dart';
import 'widgets/banners.dart';

final _shimmerGradient = LinearGradient(
  colors: [
    AppColors.white.withOpacity(0.0),
    AppColors.white.withOpacity(0.33),
    AppColors.white.withOpacity(0.66),
    AppColors.white.withOpacity(0.33),
    AppColors.white.withOpacity(0.0),
  ],
  stops: [
    0.425,
    0.462,
    0.5,
    0.538,
    0.575,
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  tileMode: TileMode.clamp,
);

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({Key? key}) : super(key: key);

  @override
  _ShoppingScreenState createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      CategoriesScreen(),
      ProductsScreen(),
    ];

    return Shimmer(
      linearGradient: _shimmerGradient,
      child: Column(
        children: [
          Banners(),
          BlocBuilder<NavigationBloc, NavigationState>(
            buildWhen: (_, state) {
              return state is Home;
            },
            builder: (_, state) {
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
                  child: pages[(_pageIndex = index)],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
