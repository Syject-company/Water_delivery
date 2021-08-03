import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/util/fade_page_route.dart';

import 'delivery_screen.dart';

abstract class DeliveryRoutes {
  static const String main = '/';
}

class DeliveryRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case DeliveryRoutes.main:
        return FadePageRoute(
          builder: (_) => DeliveryScreen(),
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
