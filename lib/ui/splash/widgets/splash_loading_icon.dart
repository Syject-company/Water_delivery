import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashLoadingIcon extends StatefulWidget {
  const SplashLoadingIcon({
    Key? key,
    required this.color,
    required this.fillColor,
  }) : super(key: key);

  final Color color;
  final Color fillColor;

  @override
  _SplashLoadingIconState createState() => _SplashLoadingIconState();
}

class _SplashLoadingIconState extends State<SplashLoadingIcon>
    with SingleTickerProviderStateMixin {
  static const String _iconPath = 'assets/svg/drop_icon.svg';
  static const Duration _fillDuration = Duration(seconds: 1);
  static const double _iconWidthFactor = 4.5;

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
              widget.fillColor,
              widget.fillColor,
              Colors.transparent,
            ],
            stops: [
              0,
              _fillAnimationController.value,
              _fillAnimationController.value,
            ]).createShader(bounds);
      },
      child: SvgPicture.asset(
        _iconPath,
        color: widget.color,
        width: MediaQuery.of(context).size.width / _iconWidthFactor,
      ),
    );
  }
}
