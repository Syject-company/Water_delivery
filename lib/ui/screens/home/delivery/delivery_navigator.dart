import 'package:flutter/material.dart';

import 'router.dart';

extension DeliveryNavigatorHelper on GlobalKey {
  void pop<T extends Object?>([T? result]) {
    return deliveryNavigator.currentState!.pop<T>();
  }

  Future<T?> pushNamed<T extends Object?>(String routeName,
      {Object? arguments}) {
    return deliveryNavigator.currentState!
        .pushNamed<T>(routeName, arguments: arguments);
  }
}

final GlobalKey<NavigatorState> deliveryNavigator = GlobalKey();

class DeliveryNavigator extends StatelessWidget {
  DeliveryNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Navigator(
        key: deliveryNavigator,
        initialRoute: DeliveryRoutes.main,
        onGenerateRoute: DeliveryRouter.generateRoute,
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    return !await deliveryNavigator.currentState!.maybePop();
  }
}
