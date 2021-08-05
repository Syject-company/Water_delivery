import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/screens/home/delivery/delivery_navigator.dart';
import 'package:water/ui/screens/home/delivery/delivery_screen.dart';
import 'package:water/ui/screens/home/notifications/notifications_screen.dart';
import 'package:water/util/slide_with_fade_page_route.dart';

import 'home_screen.dart';

abstract class HomeRoutes {
  static const String main = '/';
  static const String notifications = 'notifications';
  static const String delivery = 'delivery';
}

class HomeRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeRoutes.main:
        return SlideWithFadePageRoute(
          builder: (context) => HomeScreen(),
        );
      case HomeRoutes.notifications:
        return SlideWithFadePageRoute(
          builder: (context) => NotificationsScreen(),
        );
      case HomeRoutes.delivery:
        return SlideWithFadePageRoute(
          builder: (context) => DeliveryNavigator(),
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
