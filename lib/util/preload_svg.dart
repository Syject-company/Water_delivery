import 'package:flutter/foundation.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future<void> preloadSvg(String path) async {
  final completer = await precachePicture(
    ExactAssetPicture(SvgPicture.svgStringDecoder, path),
    null,
  );
  return completer;
}
