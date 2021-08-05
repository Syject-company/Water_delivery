import 'package:flutter/material.dart';

import 'router.dart';

final GlobalKey<NavigatorState> authNavigator = GlobalKey();

class AuthNavigator extends StatelessWidget {
  AuthNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Navigator(
        key: authNavigator,
        initialRoute: AuthRoutes.main,
        onGenerateRoute: AuthRouter.generateRoute,
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    return !await authNavigator.currentState!.maybePop();
  }
}
