import 'package:flutter/material.dart';

import 'router.dart';

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

class DeliveryNavigator extends StatelessWidget {
  DeliveryNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Navigator(
        key: _navigatorKey,
        initialRoute: DeliveryRoutes.main,
        onGenerateRoute: DeliveryRouter.generateRoute,
        observers: [HeroController()],
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    return !await _navigatorKey.currentState!.maybePop();
  }
}
