import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/auth/auth_bloc.dart';
import 'package:water/bloc/auth/forgot_password/forgot_password_bloc.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/util/slide_with_fade_route.dart';

import 'choose_auth/choose_auth_screen.dart';
import 'forgot_password/forgot_password_screen.dart';
import 'sign_in/sign_in_screen.dart';
import 'sign_up/sign_up_screen.dart';

abstract class AuthRoutes {
  static const String chooseAuth = 'choose-auth';
  static const String signIn = 'sign-in';
  static const String signUp = 'sign-up';
  static const String forgotPassword = 'forgot-password';
}

class AuthRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AuthRoutes.chooseAuth:
        return SlideWithFadeRoute(
          builder: (_) => ChooseAuthScreen(),
        );
      case AuthRoutes.signIn:
        return SlideWithFadeRoute(
          builder: (_) => BlocProvider(
            create: (_) => AuthBloc(),
            child: SignInScreen(),
          ),
        );
      case AuthRoutes.signUp:
        return SlideWithFadeRoute(
          builder: (_) => BlocProvider(
            create: (_) => AuthBloc(),
            child: SignUpScreen(),
          ),
        );
      case AuthRoutes.forgotPassword:
        return SlideWithFadeRoute(
          builder: (_) => BlocProvider(
            create: (_) => ForgotPasswordBloc(),
            child: ForgotPasswordScreen(),
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
