import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimatedLogo extends StatelessWidget {
  const AnimatedLogo({Key? key}) : super(key: key);

  static const String _logoPath = 'assets/lottie/drop-logo.json';
  static const double _iconWidthFactor = 3.25;

  @override
  Widget build(BuildContext context) {
    return _buildIcon(context);
  }

  Widget _buildIcon(BuildContext context) {
    return Lottie.asset(
      _logoPath,
      frameRate: FrameRate.max,
      width: MediaQuery.of(context).size.width / _iconWidthFactor,
      onLoaded: (composition) {},
    );
  }
}
