import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/shared_widgets/logo.dart';

class SplashLoadingIcon extends StatefulWidget {
  const SplashLoadingIcon({Key? key}) : super(key: key);

  @override
  _SplashLoadingIconState createState() => _SplashLoadingIconState();
}

class _SplashLoadingIconState extends State<SplashLoadingIcon>
    with SingleTickerProviderStateMixin {
  static const Duration _fillDuration = Duration(seconds: 1);

  late final AnimationController _fillAnimationController;

  @override
  void initState() {
    super.initState();
    _fillAnimationController =
        AnimationController(duration: _fillDuration, vsync: this)
          ..addListener(() => setState(() {}))
          ..forward();
  }

  @override
  void dispose() {
    _fillAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              AppColors.primaryColor,
              AppColors.primaryColor,
              Colors.transparent,
            ],
            stops: [
              0,
              _fillAnimationController.value,
              _fillAnimationController.value,
            ]).createShader(bounds);
      },
      child: Logo(showLabel: false),
    );
  }
}
