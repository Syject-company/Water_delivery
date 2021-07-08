import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:water/bloc/localization/localization_cubit.dart';

import 'ui/select_language/select_language_screen.dart';
import 'util/localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final savedLocale = await Localization.loadLocale();
  final flutterI18nDelegate = FlutterI18nDelegate(
    translationLoader: FileTranslationLoader(
      basePath: i18nBasePath,
      useCountryCode: false,
      fallbackFile: defaultLocale,
      forcedLocale: savedLocale,
    ),
  );

  await flutterI18nDelegate.load(savedLocale);
  runApp(GulfaWaterApp(
      flutterI18nDelegate: flutterI18nDelegate, locale: savedLocale));
}

class GulfaWaterApp extends StatelessWidget {
  GulfaWaterApp({
    Key? key,
    required this.flutterI18nDelegate,
    required this.locale,
  }) : super(key: key);

  final FlutterI18nDelegate flutterI18nDelegate;

  final Locale locale;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocalizationCubit(locale: locale),
      child: BlocBuilder<LocalizationCubit, LocalizationState>(
        builder: (_, state) => MaterialApp(
          title: 'Gulfa Water',
          // home: BlocProvider(
          //   create: (_) => SplashCubit()..startLoading(),
          //   child: SplashScreen(),
          // ),
          home: SelectLanguageScreen(),
          locale: state.locale,
          localizationsDelegates: [
            flutterI18nDelegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: Localization.locales.values,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
