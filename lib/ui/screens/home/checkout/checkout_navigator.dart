import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/checkout/date/date_bloc.dart';
import 'package:water/bloc/home/checkout/checkout_bloc.dart';
import 'package:water/ui/extensions/navigator.dart';

import 'router.dart';

export 'package:water/ui/extensions/navigator.dart';

export 'router.dart';

final GlobalKey<NavigatorState> checkoutNavigator = GlobalKey();

class CheckoutNavigator extends StatelessWidget {
  CheckoutNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => CheckoutBloc()),
          BlocProvider(
            create: (context) => DeliveryDateBloc()..add(LoadDeliveryDates()),
          ),
        ],
        child: Navigator(
          key: checkoutNavigator,
          initialRoute: CheckoutRoutes.address,
          onGenerateRoute: CheckoutRouter.generateRoute,
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    return !(await checkoutNavigator.maybePop());
  }
}
