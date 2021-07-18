import 'package:flutter/material.dart';

import 'router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: HomeRoutes.main,
      onGenerateRoute: HomeRouter.generateRoute,
    );
  }
}
