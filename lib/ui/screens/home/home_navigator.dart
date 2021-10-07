import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/auth/auth_bloc.dart';
import 'package:water/bloc/home/cart/cart_bloc.dart';
import 'package:water/bloc/home/navigation/navigation_bloc.dart';
import 'package:water/bloc/home/notifications/notifications_bloc.dart';
import 'package:water/bloc/home/profile/profile_bloc.dart';
import 'package:water/bloc/home/shopping/banners/banners_bloc.dart';
import 'package:water/bloc/home/shopping/categories/categories_bloc.dart';
import 'package:water/bloc/home/shopping/products/products_bloc.dart';
import 'package:water/bloc/home/shopping/shopping_bloc.dart';
import 'package:water/bloc/home/support/support_bloc.dart';
import 'package:water/main.dart';
import 'package:water/ui/extensions/navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/localization.dart';

import 'router.dart';

export 'package:water/ui/extensions/navigator.dart';

export 'router.dart';

final GlobalKey<NavigatorState> homeNavigator = GlobalKey();

class HomeNavigator extends StatelessWidget {
  const HomeNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final language = Localization.currentLanguage(context);

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: ToastBuilder(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => AuthBloc(),
            ),
            BlocProvider(
              create: (context) => NotificationsBloc(
                auth: context.auth,
              )..add(LoadNotifications(language: language)),
              lazy: false,
            ),
            BlocProvider(
              create: (_) =>
                  BannersBloc()..add(LoadBanners(language: language)),
              lazy: false,
            ),
            BlocProvider(
              create: (_) =>
                  CategoriesBloc()..add(LoadCategories(language: language)),
              lazy: false,
            ),
            BlocProvider(
              create: (_) => ProductsBloc(),
            ),
            BlocProvider(
              create: (context) => ShoppingBloc(
                categoriesBloc: context.categories,
                productsBloc: context.products,
              ),
            ),
            BlocProvider(
              create: (_) => CartBloc()..add(LoadCart(language: language)),
              lazy: false,
            ),
            BlocProvider(
              create: (context) => ProfileBloc(
                auth: context.auth,
              )..add(LoadProfile()),
              lazy: false,
            ),
            BlocProvider(
              create: (_) => SupportBloc(),
            ),
            BlocProvider(
              create: (context) => NavigationBloc(
                shoppingBloc: context.shopping,
              ),
            ),
          ],
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, _) {
              if (context.navigation.state is Profile) {
                context.navigation.add(
                  NavigateTo(screen: Screen.home),
                );
              }
            },
            buildWhen: (_, state) {
              return state is Unauthenticated || state is Authenticated;
            },
            builder: (_, __) {
              return Navigator(
                key: homeNavigator,
                initialRoute: HomeRoutes.main,
                onGenerateRoute: HomeRouter.generateRoute,
                observers: [HeroController()],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    return !(await homeNavigator.maybePop());
  }
}
