import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:water/bloc/splash/splash_cubit.dart';

class SplashLoadingIcon extends StatefulWidget {
  const SplashLoadingIcon({
    Key? key,
    required this.color,
    required this.fillColor,
    double initialProgress = 0.0,
  })  : initialProgress = initialProgress,
        super(key: key);

  final Color color;
  final Color fillColor;
  final double initialProgress;

  @override
  _SplashLoadingIconState createState() => _SplashLoadingIconState();
}

class _SplashLoadingIconState extends State<SplashLoadingIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _fillAnimationController;

  @override
  void initState() {
    super.initState();
    _fillAnimationController = AnimationController(vsync: this)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _fillAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashCubit, SplashState>(
      builder: (_, state) {
        _fillAnimationController.animateTo(
          state.progress,
          duration: Duration(milliseconds: 1000),
          curve: Curves.decelerate,
        );

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
            'assets/svg/drop_icon.svg',
            color: widget.color,
            width: MediaQuery.of(context).size.width / 4,
          ),
        );
      },
    );
  }
}
