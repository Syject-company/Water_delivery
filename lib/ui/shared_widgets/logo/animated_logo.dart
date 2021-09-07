import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:water/ui/constants/paths.dart';

const double _iconWidthFactor = 3.25;

class WaterAnimatedLogo extends StatelessWidget {
  const WaterAnimatedLogo({
    Key? key,
    this.widthFactor = _iconWidthFactor,
  }) : super(key: key);

  final double widthFactor;

  @override
  Widget build(BuildContext context) {
    return _buildIcon(context);
  }

  Widget _buildIcon(BuildContext context) {
    return Lottie.asset(
      Paths.drop_logo,
      frameRate: FrameRate.max,
      width: MediaQuery.of(context).size.width / widthFactor,
    );
  }
}
