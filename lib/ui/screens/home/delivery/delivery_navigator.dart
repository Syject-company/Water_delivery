import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/delivery/date/date_bloc.dart';
import 'package:water/bloc/home/delivery/delivery_bloc.dart';
import 'package:water/ui/extensions/navigator.dart';

import 'router.dart';

final GlobalKey<NavigatorState> deliveryNavigator = GlobalKey();

class DeliveryNavigator extends StatelessWidget {
  DeliveryNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => DeliveryBloc()),
          BlocProvider(
            create: (context) => DeliveryDateBloc()..add(LoadDeliveryDates()),
          ),
        ],
        child: BlocListener<DeliveryBloc, DeliveryState>(
          listener: (context, state) async {
            if (state is DeliveryTimeInput) {
              await deliveryNavigator.pushNamed(DeliveryRoutes.time);
              print('back from time');
            } else if (state is DeliveryDetailsCollected) {
              await deliveryNavigator.pushNamed(DeliveryRoutes.payment);
              print('back from payment');
            }
          },
          child: Navigator(
            key: deliveryNavigator,
            initialRoute: DeliveryRoutes.address,
            onGenerateRoute: DeliveryRouter.generateRoute,
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    return !(await deliveryNavigator.maybePop());
  }
}
