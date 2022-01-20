import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sizer/sizer.dart';
import 'package:water/ui/shared_widgets/water.dart';

import 'locator.dart';
import 'resources_preloader.dart';
import 'ui/screens/router.dart';
import 'utils/local_notification.dart';
import 'utils/local_storage.dart' as water;
import 'utils/localization.dart';
import 'utils/notifications_util.dart';
import 'utils/session.dart';
import 'utils/shopping_cart.dart';

export 'package:water/ui/extensions/navigator.dart';

export 'ui/screens/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  await water.LocalStorage.ensureInitialized();
  await LocalNotifications.ensureInitialized();
  await NotificationsUtil.ensureInitialized();
  await ShoppingCart.ensureInitialized();
  await Session.ensureInitialized();
  await preloadResources();
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
        shouldInterceptRequest: (_) async {
          return null;
        },
      );
    }
  }

  await _initializeFirebaseCrashlytics();

  runApp(
    DevicePreview(
      enabled: false,
      builder: (_) {
        return Sizer(
          builder: (_, __, ___) {
            return EasyLocalization(
              saveLocale: false,
              startLocale: Localization.loadLocale(),
              supportedLocales: Localization.locales,
              path: Localization.i18nBasePath,
              useOnlyLangCode: !Localization.useCountryCode,
              fallbackLocale: Localization.defaultLocale,
              useFallbackTranslations: true,
              assetLoader: YamlAssetLoader(),
              child: GulfaWaterApp(),
            );
          },
        );
      },
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
        return DevicePreview.appBuilder(
          context,
          ResponsiveWrapper.builder(
            child,
            minWidth: 414,
            defaultScale: true,
            breakpoints: [
              ResponsiveBreakpoint.resize(
                480,
                name: MOBILE,
                scaleFactor: 1.25,
              ),
              ResponsiveBreakpoint.autoScale(
                800,
                name: TABLET,
                scaleFactor: 1.25,
              ),
            ],
          ),
        );
      },
      theme: theme,
      title: 'Gulfa',
      navigatorKey: appNavigator,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: RootRouter.generateRoute,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
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

Future<void> _initializeFirebaseCrashlytics() async {
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  await FirebaseCrashlytics.instance
      .setCrashlyticsCollectionEnabled(!kDebugMode);

  final originalOnError = FlutterError.onError;
  FlutterError.onError = (FlutterErrorDetails errorDetails) async {
    await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    originalOnError?.call(errorDetails);
  };
}

class ResponsiveUtils {
  static late MediaQueryData _mediaQueryData;

  static MediaQueryData get mediaQuery => _mediaQueryData;

  static void setMediaQuery(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
  }
}
