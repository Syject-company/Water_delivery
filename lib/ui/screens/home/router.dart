import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/main/cart/cart_bloc.dart';
import 'package:water/bloc/home/main/categories/categories_bloc.dart';
import 'package:water/bloc/home/main/main_bloc.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/util/slide_with_fade_route.dart';

import 'main/main_screen.dart';

abstract class HomeRoutes {
  static const String main = 'main';
}

class HomeRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeRoutes.main:
        return SlideWithFadeRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => MainBloc()),
              BlocProvider(create: (context) => CategoriesBloc()),
              BlocProvider(create: (context) => CartBloc()),
            ],
            child: MainScreen(),
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
