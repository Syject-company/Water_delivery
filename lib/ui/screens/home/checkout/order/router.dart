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
import 'order_payment/order_payment_screen.dart';

abstract class OrderRoutes {
  static const String deliveryAddress = 'delivery-address';
  static const String deliveryTime = 'delivery-time';
  static const String orderPayment = 'order-payment';
}

class CheckoutRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case OrderRoutes.deliveryAddress:
        return SlideWithFadePageRoute(
          builder: (_) => DeliveryAddressScreen(),
        );
      case OrderRoutes.deliveryTime:
        return SlideWithFadePageRoute(
          builder: (_) => DeliveryTimeScreen(),
        );
      case OrderRoutes.orderPayment:
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
            child: OrderPaymentScreen(),
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
