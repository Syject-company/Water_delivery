import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/orders/orders_bloc.dart';
import 'package:water/bloc/home/subscriptions/subscriptions_bloc.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/screens/home/delivery/delivery_navigator.dart';
import 'package:water/ui/screens/home/faq/faq_screen.dart';
import 'package:water/ui/screens/home/notifications/notifications_screen.dart';
import 'package:water/ui/screens/home/orders/orders_screen.dart';
import 'package:water/ui/screens/home/refer_friend/refer_friend_screen.dart';
import 'package:water/ui/screens/home/subscriptions/subscriptions_screen.dart';
import 'package:water/ui/screens/home/support/support_screen.dart';
import 'package:water/ui/screens/home/terms/terms_screen.dart';
import 'package:water/ui/screens/home/wallet/wallet_screen.dart';
import 'package:water/util/slide_with_fade_page_route.dart';

import 'home_screen.dart';

abstract class HomeRoutes {
  static const String main = '/';
  static const String wallet = 'wallet';
  static const String notifications = 'notifications';
  static const String orders = 'orders';
  static const String subscriptions = 'subscriptions';
  static const String delivery = 'delivery';
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
      case HomeRoutes.delivery:
        return SlideWithFadePageRoute(
          builder: (context) => DeliveryNavigator(),
        );
      case HomeRoutes.faq:
        return SlideWithFadePageRoute(
          builder: (context) => FAQScreen(),
        );
      case HomeRoutes.terms:
        return SlideWithFadePageRoute(
          builder: (context) => TermsScreen(),
        );
      case HomeRoutes.referFriend:
        return SlideWithFadePageRoute(
          builder: (context) => ReferFriendScreen(),
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
