import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/auth/sign_in/sign_in_bloc.dart';
import 'package:water/bloc/auth/sign_up/sign_up_bloc.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/util/slide_with_fade_route.dart';

import 'choose_auth/choose_auth_screen.dart';
import 'sign_in/sign_in_screen.dart';
import 'sign_up/sign_up_screen.dart';

abstract class AuthRoutes {
  static const String chooseAuth = 'choose-auth';
  static const String signIn = 'sign-in';
  static const String signUp = 'sign-up';
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
            create: (_) => SignInBloc(),
            child: SignInScreen(),
          ),
        );
      case AuthRoutes.signUp:
        return SlideWithFadeRoute(
          builder: (_) => BlocProvider(
            create: (_) => SignUpBloc(),
            child: SignUpScreen(),
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
