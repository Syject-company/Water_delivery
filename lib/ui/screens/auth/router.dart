import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/auth/auth_bloc.dart';
import 'package:water/bloc/auth/forgot_password/forgot_password_bloc.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/util/fade_page_route.dart';

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
        return FadePageRoute(
          builder: (_) => AuthScreen(),
        );
      case AuthRoutes.signIn:
        return FadePageRoute(
          builder: (_) => BlocProvider(
            create: (_) => AuthBloc(),
            child: SignInScreen(),
          ),
        );
      case AuthRoutes.signUp:
        return FadePageRoute(
          builder: (_) => BlocProvider(
            create: (_) => AuthBloc(),
            child: SignUpScreen(),
          ),
        );
      case AuthRoutes.forgotPassword:
        return FadePageRoute(
          builder: (_) => BlocProvider(
            create: (_) => ForgotPasswordBloc(),
            child: ForgotPasswordScreen(),
          ),
        );
      default:
        return FadePageRoute(
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
