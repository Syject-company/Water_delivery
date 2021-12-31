import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/cart/cart_bloc.dart';
import 'package:water/bloc/home/checkout/payment/payment_bloc.dart';
import 'package:water/bloc/home/profile/profile_bloc.dart';
import 'package:water/bloc/home/promo_codes/promo_codes_bloc.dart';
import 'package:water/app_colors.dart';
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
          builder: (_) => DeliveryAddressScreen(),
        );
      case SubscriptionRoutes.subscriptionDuration:
        return SlideWithFadePageRoute(
          builder: (_) => SubscriptionDurationScreen(),
        );
      case SubscriptionRoutes.deliveryTime:
        return SlideWithFadePageRoute(
          builder: (_) => DeliveryTimeScreen(),
        );
      case SubscriptionRoutes.payment:
        return SlideWithFadePageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => PaymentBloc(
                  profile: context.profile,
                  cart: context.cart,
                ),
              ),
              BlocProvider(create: (_) => PromoCodesBloc()),
            ],
            child: SubscriptionPaymentScreen(),
          ),
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
