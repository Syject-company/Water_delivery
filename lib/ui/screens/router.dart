import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/splash/splash_bloc.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/slide_with_fade_page_route.dart';

import 'home/home_navigator.dart';
import 'splash/select_language_screen.dart';
import 'splash/splash_screen.dart';

abstract class AppRoutes {
  static const String splash = 'splash';
  static const String selectLanguage = 'select-language';
  static const String home = 'home';
}

class RootRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return SlideWithFadePageRoute(
          builder: (_) => BlocProvider(
            create: (_) => SplashBloc()..add(PreloadImages()),
            child: SplashScreen(),
          ),
        );
      case AppRoutes.selectLanguage:
        return SlideWithFadePageRoute(
          builder: (_) => SelectLanguageScreen(),
        );
      case AppRoutes.home:
        return SlideWithFadePageRoute(
          builder: (_) => HomeNavigator(),
        );
      default:
        return SlideWithFadePageRoute(
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
