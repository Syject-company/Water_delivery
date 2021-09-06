import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/util/local_storage.dart' as water;
import 'package:water/util/localization.dart';
import 'package:water/util/session.dart';
import 'package:water/util/shopping_cart.dart';

import 'locator.dart';
import 'ui/screens/router.dart';

export 'package:water/ui/extensions/navigator.dart';

export 'ui/screens/router.dart';

const double _iPhoneProMaxWidth = 414;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await water.LocalStorage.ensureInitialized();
  await ShoppingCart.ensureInitialized();
  await Session.ensureInitialized();
  setupLocator();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

    var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
    var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

    if (swAvailable && swInterceptAvailable) {
      AndroidServiceWorkerController serviceWorkerController =
      AndroidServiceWorkerController.instance();

      serviceWorkerController.serviceWorkerClient = AndroidServiceWorkerClient(
        shouldInterceptRequest: (request) async {
          print(request);
          return null;
        },
      );
    }
  }

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

final GlobalKey<NavigatorState> appNavigator = GlobalKey();

class GulfaWaterApp extends StatelessWidget {
  const GulfaWaterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return ResponsiveWrapper.builder(
          child,
          minWidth: _iPhoneProMaxWidth,
          defaultScale: true,
        );
      },
      theme: theme,
      title: 'Gulfa Water',
      navigatorKey: appNavigator,
      initialRoute: AppRoutes.home,
      onGenerateRoute: RootRouter.generateRoute,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
    );
  }

  ThemeData get theme {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.white,
      dialogBackgroundColor: AppColors.white,
      backgroundColor: AppColors.white,
    );
  }
}
