import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:water/app_resources.dart';
import 'package:water/ui/shared_widgets/water.dart';

class WaterAnimatedLogo extends StatelessWidget {
  const WaterAnimatedLogo({
    Key? key,
    required this.widthFactor,
  }) : super(key: key);

  final double widthFactor;

  @override
  Widget build(BuildContext context) {
    return _buildIcon(context);
  }

  Widget _buildIcon(BuildContext context) {
    return Lottie.asset(
      AppResources.dropLogo,
      frameRate: FrameRate.max,
      width: 100.w / (isMobile ? widthFactor : widthFactor * 1.5),
    );
  }
}
