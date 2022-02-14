import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/checkout/dates/dates_bloc.dart';
import 'package:water/bloc/home/checkout/subscription/subscription_bloc.dart';
import 'package:water/ui/extensions/navigator.dart';

import 'router.dart';

export 'package:water/ui/extensions/navigator.dart';

export 'router.dart';

final GlobalKey<NavigatorState> subscriptionNavigator = GlobalKey();

class SubscriptionNavigator extends StatelessWidget {
  const SubscriptionNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => SubscriptionBloc()),
          BlocProvider(create: (_) => DeliveryDatesBloc()),
        ],
        child: Navigator(
          key: subscriptionNavigator,
          initialRoute: SubscriptionRoutes.deliveryAddress,
          onGenerateRoute: SubscriptionRouter.generateRoute,
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    return !(await subscriptionNavigator.maybePop());
  }
}
