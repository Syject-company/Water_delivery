import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/checkout/dates/dates_bloc.dart';
import 'package:water/bloc/home/checkout/order/order_bloc.dart';
import 'package:water/ui/extensions/navigator.dart';

import 'router.dart';

export 'package:water/ui/extensions/navigator.dart';

export 'router.dart';

final GlobalKey<NavigatorState> orderNavigator = GlobalKey();

class OrderNavigator extends StatelessWidget {
  const OrderNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => OrderBloc()),
          BlocProvider(create: (_) => DeliveryDatesBloc()),
        ],
        child: Navigator(
          key: orderNavigator,
          initialRoute: OrderRoutes.deliveryAddress,
          onGenerateRoute: CheckoutRouter.generateRoute,
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    return !(await orderNavigator.maybePop());
  }
}
