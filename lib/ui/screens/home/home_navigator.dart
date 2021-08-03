import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/cart/cart_bloc.dart';
import 'package:water/bloc/home/navigation/navigation_bloc.dart';
import 'package:water/bloc/home/notification/notification_bloc.dart';
import 'package:water/bloc/home/shop/shop_bloc.dart';
import 'package:water/ui/shared_widgets/toast.dart';

import 'router.dart';

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

class HomeNavigator extends StatelessWidget {
  HomeNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: ToastBuilder(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ShopBloc()),
            BlocProvider(create: (context) => CartBloc()),
            BlocProvider(create: (context) => NotificationsBloc()),
            BlocProvider(
              create: (context) => NavigationBloc(shopBloc: context.shop),
            ),
          ],
          child: Navigator(
            key: _navigatorKey,
            initialRoute: HomeRoutes.delivery,
            onGenerateRoute: HomeRouter.generateRoute,
            observers: [HeroController()],
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    return !await _navigatorKey.currentState!.maybePop();
  }
}
