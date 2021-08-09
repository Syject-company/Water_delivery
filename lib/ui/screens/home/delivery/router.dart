import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/screens/home/delivery/payment/payment_screen.dart';
import 'package:water/ui/screens/home/delivery/time/time_screen.dart';
import 'package:water/util/slide_with_fade_page_route.dart';

import 'delivery_screen.dart';

abstract class DeliveryRoutes {
  static const String main = '/';
  static const String time = 'time';
  static const String payment = 'payment';
}

class DeliveryRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case DeliveryRoutes.main:
        return SlideWithFadePageRoute(
          builder: (_) => DeliveryScreen(),
        );
      case DeliveryRoutes.time:
        return SlideWithFadePageRoute(
          builder: (_) => TimeScreen(),
        );
      case DeliveryRoutes.payment:
        return SlideWithFadePageRoute(
          builder: (_) => PaymentScreen(),
        );
      default:
        return SlideWithFadePageRoute(
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
