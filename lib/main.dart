import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/splash/splash_cubit.dart';

import 'ui/select_language/select_language_screen.dart';
import 'ui/splash/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: BlocProvider(
      //   create: (_) => SplashCubit()..startLoading(),
      //   child: SplashScreen(),
      // ),
      home: SelectLanguageScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
