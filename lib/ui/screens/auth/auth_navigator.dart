import 'package:flutter/material.dart';

import 'router.dart';

class AuthNavigator extends StatelessWidget {
  AuthNavigator({Key? key}) : super(key: key);

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Navigator(
        key: _navigatorKey,
        initialRoute: AuthRoutes.main,
        onGenerateRoute: AuthRouter.generateRoute,
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    return !await _navigatorKey.currentState!.maybePop();
  }
}
