import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/splash/splash_bloc.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/loader_overlay.dart';
import 'package:water/util/fade_page_route.dart';

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
        return FadePageRoute(
          builder: (_) => BlocProvider<SplashBloc>(
            create: (_) => SplashBloc()..add(Loading()),
            child: SplashScreen(),
          ),
        );
      case AppRoutes.auth:
        return FadePageRoute(
          builder: (_) => LoaderOverlay(
            child: AuthNavigator(),
          ),
        );
      case AppRoutes.home:
        return FadePageRoute(
          builder: (_) => LoaderOverlay(
            child: HomeNavigator(),
          ),
        );
      default:
        return FadePageRoute(
          builder: (_) => Scaffold(
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
