import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/auth/auth_cubit.dart';

import 'router.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: Navigator(
        initialRoute: AuthRoutes.chooseAuth,
        onGenerateRoute: AuthRouter.generateRoute,
      ),
    );
  }
}
