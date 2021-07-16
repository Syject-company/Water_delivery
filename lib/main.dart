import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/splash/splash_bloc.dart';
import 'package:water/domain/model/auth/new_password_form.dart';
import 'package:water/ui/screens/router.dart';
import 'package:water/ui/screens/splash/splash_screen.dart';
import 'package:water/ui/shared_widgets/loader_overlay.dart';
import 'package:water/util/local_storage.dart';
import 'package:water/util/localization.dart';
import 'package:water/util/session.dart';

import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await LocalStorage.ensureInitialized();
  await Session.ensureInitialized();
  setupLocator();

  runApp(
    EasyLocalization(
      saveLocale: false,
      startLocale: Localization.loadLocale(),
      supportedLocales: Localization.locales,
      path: Localization.i18nBasePath,
      useOnlyLangCode: !Localization.useCountryCode,
      fallbackLocale: Localization.defaultLocale,
      useFallbackTranslations: true,
      assetLoader: YamlAssetLoader(),
      child: GulfaWaterApp(),
    ),
  );
}

class GulfaWaterApp extends StatelessWidget {
  GulfaWaterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gulfa Water',
      initialRoute: AppRoutes.splash,
      onGenerateRoute: RootRouter.generateRoute,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      debugShowCheckedModeBanner: false,
    );
  }
}
