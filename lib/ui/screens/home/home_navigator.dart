import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/cart/cart_bloc.dart';
import 'package:water/bloc/home/navigation/navigation_bloc.dart';
import 'package:water/bloc/home/notification/notification_bloc.dart';
import 'package:water/bloc/home/shopping/categories/categories_bloc.dart';
import 'package:water/bloc/home/shopping/products/products_bloc.dart';
import 'package:water/bloc/home/shopping/shopping_bloc.dart';
import 'package:water/bloc/home/wallet/wallet_bloc.dart';
import 'package:water/ui/extensions/navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';

import 'router.dart';

final GlobalKey<NavigatorState> homeNavigator = GlobalKey();

class HomeNavigator extends StatelessWidget {
  HomeNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: ToastBuilder(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => WalletBloc()),
            BlocProvider(create: (context) => CategoriesBloc()),
            BlocProvider(create: (context) => ProductsBloc()),
            BlocProvider(
              create: (context) => ShoppingBloc(
                categoriesBloc: context.categories,
                productsBloc: context.products,
              ),
            ),
            BlocProvider(create: (context) => CartBloc()),
            BlocProvider(create: (context) => NotificationsBloc()),
            BlocProvider(
              create: (context) => NavigationBloc(
                shoppingBloc: context.shopping,
              ),
            ),
          ],
          child: Navigator(
            key: homeNavigator,
            initialRoute: HomeRoutes.main,
            onGenerateRoute: HomeRouter.generateRoute,
            observers: [HeroController()],
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    return !await homeNavigator.maybePop();
  }
}
