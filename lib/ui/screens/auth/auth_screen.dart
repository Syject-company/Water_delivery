import 'package:flutter/material.dart';

import 'router.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: AuthRoutes.ChooseAuth,
      onGenerateRoute: AuthRouter.generateRoute,
    );
  }
}
