import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/orders/orders_bloc.dart';
import 'package:water/bloc/home/subscriptions/subscriptions_bloc.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/util/slide_with_fade_page_route.dart';

import 'auth/auth_navigator.dart';
import 'checkout/checkout_navigator.dart';
import 'faq/faq_screen.dart';
import 'home_screen.dart';
import 'notifications/notifications_screen.dart';
import 'orders/orders_screen.dart';
import 'subscriptions/subscriptions_screen.dart';
import 'support/support_screen.dart';
import 'terms/terms_screen.dart';
import 'wallet/wallet_screen.dart';

abstract class HomeRoutes {
  static const String main = '/';
  static const String auth = 'auth';
  static const String wallet = 'wallet';
  static const String notifications = 'notifications';
  static const String orders = 'orders';
  static const String subscriptions = 'subscriptions';
  static const String checkout = 'checkout';
  static const String faq = 'faq';
  static const String terms = 'terms';
  static const String referFriend = 'refer-friend';
  static const String support = 'support';
}

class HomeRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeRoutes.main:
        return SlideWithFadePageRoute(
          builder: (context) => HomeScreen(),
        );
      case HomeRoutes.auth:
        return SlideWithFadePageRoute(
          builder: (context) => AuthNavigator(),
        );
      case HomeRoutes.wallet:
        return SlideWithFadePageRoute(
          builder: (context) => WalletScreen(),
        );
      case HomeRoutes.notifications:
        return SlideWithFadePageRoute(
          builder: (context) => NotificationsScreen(),
        );
      case HomeRoutes.orders:
        return SlideWithFadePageRoute(
          builder: (context) => BlocProvider(
            create: (context) => OrdersBloc()..add(LoadOrders()),
            child: OrdersScreen(),
          ),
        );
      case HomeRoutes.subscriptions:
        return SlideWithFadePageRoute(
          builder: (context) => BlocProvider(
            create: (context) => SubscriptionsBloc()..add(LoadSubscriptions()),
            child: SubscriptionsScreen(),
          ),
        );
      case HomeRoutes.checkout:
        return SlideWithFadePageRoute(
          builder: (context) => CheckoutNavigator(),
        );
      case HomeRoutes.faq:
        return SlideWithFadePageRoute(
          builder: (context) => FAQScreen(),
        );
      case HomeRoutes.terms:
        return SlideWithFadePageRoute(
          builder: (context) => TermsScreen(),
        );
      case HomeRoutes.support:
        return SlideWithFadePageRoute(
          builder: (context) => SupportScreen(),
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
