import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/splash/splash_bloc.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/slide_with_fade_page_route.dart';

import 'auth/auth_navigator.dart';
import 'splash/splash_screen.dart';

abstract class AppRoutes {
  static const String splash = 'splash';
  static const String auth = 'auth';
  static const String home = 'home';
}

class RootRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return SlideWithFadePageRoute(
          builder: (context) => BlocProvider<SplashBloc>(
            create: (context) => SplashBloc()..add(Loading()),
            child: SplashScreen(),
          ),
        );
      case AppRoutes.auth:
        return SlideWithFadePageRoute(
          builder: (context) => LoaderOverlay(
            child: AuthNavigator(),
          ),
        );
      case AppRoutes.home:
        return SlideWithFadePageRoute(
          builder: (context) => LoaderOverlay(
            child: HomeNavigator(),
          ),
        );
      default:
        return SlideWithFadePageRoute(
          builder: (context) => Scaffold(
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
          ),
        );
    }
  }
}
