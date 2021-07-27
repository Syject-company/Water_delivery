import 'package:flutter/material.dart';

import 'router.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Navigator(
        key: _navigatorKey,
        initialRoute: HomeRoutes.main,
        onGenerateRoute: HomeRouter.generateRoute,
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    return !await _navigatorKey.currentState!.maybePop();
  }
}
