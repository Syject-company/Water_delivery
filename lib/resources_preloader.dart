import 'package:flutter/painting.dart';

import 'app_resources.dart';
import 'utils/preload_image.dart';
import 'utils/preload_svg.dart';

Future<void> preloadResources() async {
  await Future.wait([
    preloadSvg(AppResources.logoIcon),
    preloadSvg(AppResources.logoLabelWhite),
    preloadSvg(AppResources.logoLabelColored),
  ]);

  await Future.wait([
    preloadImage(const AssetImage(AppResources.logo)),
  ]);
}
