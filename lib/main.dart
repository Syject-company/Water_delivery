import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:water/bloc/splash/splash_cubit.dart';
import 'package:water/ui/screens/splash/splash_screen.dart';

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
      home: BlocProvider<SplashCubit>(
        create: (_) => SplashCubit(),
        child: SplashScreen(),
      ),
      theme: ThemeData(
        textTheme:
            GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).copyWith(
        ),
      ),
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      debugShowCheckedModeBanner: false,
    );
  }
}
