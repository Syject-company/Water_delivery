import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/screens/home/checkout/payment/payment_screen.dart';
import 'package:water/ui/screens/home/checkout/time/time_screen.dart';
import 'package:water/util/slide_with_fade_page_route.dart';

import 'address/address_screen.dart';

abstract class CheckoutRoutes {
  static const String address = 'address';
  static const String time = 'time';
  static const String payment = 'payment';
}

class CheckoutRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CheckoutRoutes.address:
        return SlideWithFadePageRoute(
          builder: (context) => DeliveryAddressScreen(),
        );
      case CheckoutRoutes.time:
        return SlideWithFadePageRoute(
          builder: (context) => DeliveryTimeScreen(),
        );
      case CheckoutRoutes.payment:
        return SlideWithFadePageRoute(
          builder: (context) => PaymentScreen(),
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
