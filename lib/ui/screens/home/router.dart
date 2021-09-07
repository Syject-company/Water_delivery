import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/orders/orders_bloc.dart';
import 'package:water/bloc/home/profile/change_password/change_password_bloc.dart';
import 'package:water/bloc/home/subscriptions/subscriptions_bloc.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/screens/home/profile/change_password/change_password_screen.dart';
import 'package:water/util/slide_with_fade_page_route.dart';

import 'auth/auth_navigator.dart';
import 'checkout/order/order_navigator.dart';
import 'checkout/subscription/subscription_navigator.dart';
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
  static const String changePassword = 'change-password';
  static const String wallet = 'wallet';
  static const String notifications = 'notifications';
  static const String order = 'order';
  static const String orders = 'orders';
  static const String subscription = 'subscription';
  static const String subscriptions = 'subscriptions';
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
          builder: (_) => HomeScreen(),
        );
      case HomeRoutes.auth:
        return SlideWithFadePageRoute(
          builder: (_) => AuthNavigator(),
        );
      case HomeRoutes.changePassword:
        return SlideWithFadePageRoute(
          builder: (_) => BlocProvider(
            create: (_) => ChangePasswordBloc(),
            child: ChangePasswordScreen(),
          ),
        );
      case HomeRoutes.wallet:
        return SlideWithFadePageRoute(
          builder: (_) => WalletScreen(),
        );
      case HomeRoutes.notifications:
        return SlideWithFadePageRoute(
          builder: (_) => NotificationsScreen(),
        );
      case HomeRoutes.order:
        return SlideWithFadePageRoute(
          builder: (_) => OrderNavigator(),
        );
      case HomeRoutes.orders:
        return SlideWithFadePageRoute(
          builder: (_) => BlocProvider(
            create: (_) => OrdersBloc()..add(LoadOrders()),
            child: OrdersScreen(),
          ),
        );
      case HomeRoutes.subscription:
        return SlideWithFadePageRoute(
          builder: (_) => SubscriptionNavigator(),
        );
      case HomeRoutes.subscriptions:
        return SlideWithFadePageRoute(
          builder: (_) => BlocProvider(
            create: (_) => SubscriptionsBloc()..add(LoadSubscriptions()),
            child: SubscriptionsScreen(),
          ),
        );
      case HomeRoutes.faq:
        return SlideWithFadePageRoute(
          builder: (_) => FAQScreen(),
        );
      case HomeRoutes.terms:
        return SlideWithFadePageRoute(
          builder: (_) => TermsScreen(),
        );
      case HomeRoutes.support:
        return SlideWithFadePageRoute(
          builder: (_) => SupportScreen(),
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
