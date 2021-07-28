import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/cart/cart_bloc.dart';
import 'package:water/bloc/home/navigation/navigation_bloc.dart';
import 'package:water/bloc/home/shop/shop_bloc.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/util/slide_with_fade_route.dart';

import 'home_screen.dart';

abstract class HomeRoutes {
  static const String main = '/';
}

class HomeRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeRoutes.main:
        return SlideWithFadeRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => NavigationBloc()),
              BlocProvider(
                create: (context) => ShopBloc()..add(LoadCategories()),
              ),
              BlocProvider(create: (context) => CartBloc()),
            ],
            child: HomeScreen(),
          ),
        );
      default:
        return SlideWithFadeRoute(
          builder: (_) {
            return Scaffold(
              body: Center(
                child: Text(
                  'No route defined for ${settings.name}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          },
        );
    }
  }
}
