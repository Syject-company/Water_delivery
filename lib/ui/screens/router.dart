import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/splash/splash_bloc.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/screens/home/home_screen.dart';
import 'package:water/ui/shared_widgets/loader_overlay.dart';
import 'package:water/util/slide_with_fade_route.dart';

import 'auth/auth_screen.dart';
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
        return SlideWithFadeRoute(
          builder: (_) => BlocProvider<SplashBloc>(
            create: (_) => SplashBloc()..add(Loading()),
            child: SplashScreen(),
          ),
        );
      case AppRoutes.auth:
        return SlideWithFadeRoute(
          builder: (_) => LoaderOverlay(
            child: AuthScreen(),
          ),
        );
      case AppRoutes.home:
        return SlideWithFadeRoute(
          builder: (_) => LoaderOverlay(
            child: HomeScreen(),
          ),
        );
      default:
        return SlideWithFadeRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                'No route defined for ${settings.name}',
                style: const TextStyle(
                  fontSize: 18.0,
                  color: AppColors.primaryTextColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
    }
  }
}
