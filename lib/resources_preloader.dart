import 'package:flutter/painting.dart';

import 'app_resources.dart';
import 'util/preload_image.dart';
import 'util/preload_svg.dart';

Future<void> preloadResources() async {
  await Future.wait([
    preloadSvg(AppResources.logo_icon),
    preloadSvg(AppResources.logo_label_white),
    preloadSvg(AppResources.logo_label_colored),
  ]);

  await Future.wait([
    preloadImage(const AssetImage(AppResources.icon)),
  ]);
}
