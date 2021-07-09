import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';

import 'ui/select_language/select_language_screen.dart';
import 'util/localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final startLocale = await Localization.loadLocale();

  runApp(
    EasyLocalization(
      saveLocale: false,
      startLocale: startLocale,
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
      // home: BlocProvider(
      //   create: (_) => SplashCubit()..startLoading(),
      //   child: SplashScreen(),
      // ),
      home: SelectLanguageScreen(),
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      debugShowCheckedModeBanner: false,
    );
  }
}
