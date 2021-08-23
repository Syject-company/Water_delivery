import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/auth/forgot_password/forgot_password_bloc.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/util/slide_with_fade_page_route.dart';

import 'auth_screen.dart';
import 'forgot_password/forgot_password_screen.dart';
import 'sign_in/sign_in_screen.dart';
import 'sign_up/sign_up_screen.dart';

abstract class AuthRoutes {
  static const String main = '/';
  static const String signIn = 'sign-in';
  static const String signUp = 'sign-up';
  static const String forgotPassword = 'forgot-password';
}

class AuthRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AuthRoutes.main:
        return SlideWithFadePageRoute(
          builder: (context) => AuthScreen(),
        );
      case AuthRoutes.signIn:
        return SlideWithFadePageRoute(
          builder: (context) => SignInScreen(),
        );
      case AuthRoutes.signUp:
        return SlideWithFadePageRoute(
          builder: (context) => SignUpScreen(),
        );
      case AuthRoutes.forgotPassword:
        return SlideWithFadePageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ForgotPasswordBloc(),
            child: ForgotPasswordScreen(),
          ),
        );
      default:
        return SlideWithFadePageRoute(
          builder: (context) {
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
