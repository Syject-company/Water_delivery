import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/cart/cart_bloc.dart';
import 'package:water/bloc/home/checkout/payment/payment_bloc.dart';
import 'package:water/bloc/home/wallet/wallet_bloc.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/util/slide_with_fade_page_route.dart';

import 'delivery_address/delivery_address_screen.dart';
import 'delivery_time/delivery_time_screen.dart';
import 'subscription_duration/subscription_duration_screen.dart';
import 'subscription_payment/subscription_payment_screen.dart';

abstract class SubscriptionRoutes {
  static const String deliveryAddress = 'delivery-address';
  static const String subscriptionDuration = 'subscription-duration';
  static const String deliveryTime = 'delivery-time';
  static const String payment = 'payment';
}

class SubscriptionRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SubscriptionRoutes.deliveryAddress:
        return SlideWithFadePageRoute(
          builder: (context) => DeliveryAddressScreen(),
        );
      case SubscriptionRoutes.subscriptionDuration:
        return SlideWithFadePageRoute(
          builder: (context) => SubscriptionDurationScreen(),
        );
      case SubscriptionRoutes.deliveryTime:
        return SlideWithFadePageRoute(
          builder: (context) => DeliveryTimeScreen(),
        );
      case SubscriptionRoutes.payment:
        return SlideWithFadePageRoute(
          builder: (context) => BlocProvider(
            create: (context) => PaymentBloc(
              wallet: context.wallet,
              cart: context.cart,
            ),
            child: SubscriptionPaymentScreen(),
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
