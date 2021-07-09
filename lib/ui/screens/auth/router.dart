import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/screens/auth/choose_auth/choose_auth_screen.dart';
import 'package:water/util/slide_with_fade_route.dart';

import 'sign_in/sign_in_screen.dart';

abstract class AuthRoutes {
  static const String ChooseAuth = 'choose-auth';
  static const String SignIn = 'sign-in';
}

class AuthRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AuthRoutes.ChooseAuth:
        return SlideWithFadeRoute(
          builder: (_) => ChooseAuthScreen(),
        );
      case AuthRoutes.SignIn:
        return SlideWithFadeRoute(
          builder: (_) => SignInScreen(),
        );
      default:
        return SlideWithFadeRoute(
          builder: (context) {
            return Scaffold(
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
            );
          },
        );
    }
  }
}
