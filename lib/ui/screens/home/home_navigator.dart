import 'package:flutter/material.dart';
import 'package:water/ui/shared_widgets/toast.dart';

import 'router.dart';

class HomeNavigator extends StatelessWidget {
  HomeNavigator({Key? key}) : super(key: key);

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: ToastBuilder(
        child: Navigator(
          key: _navigatorKey,
          initialRoute: HomeRoutes.main,
          onGenerateRoute: HomeRouter.generateRoute,
          observers: [HeroController()],
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    return !await _navigatorKey.currentState!.maybePop();
  }
}
