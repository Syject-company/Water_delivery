import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:water/bloc/splash/splash_cubit.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/screens/auth/auth_screen.dart';
import 'package:water/ui/screens/select_language/select_language_screen.dart';
import 'package:water/util/slide_with_fade_route.dart';

import 'widgets/splash_loading_icon.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  static const String _splashVideoPath = 'assets/video/splash_video.mp4';
  static const Duration _fadeDuration = Duration(milliseconds: 375);

  late final AnimationController _fadeAnimationController;

  final VideoPlayerController _videoController =
      VideoPlayerController.asset(_splashVideoPath);

  @override
  void initState() {
    super.initState();
    _fadeAnimationController = AnimationController(
      duration: _fadeDuration,
      vsync: this,
    )..forward();
    _videoController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _fadeAnimationController.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashCubit, SplashState>(
      listener: (_, state) async {
        if (state is SplashVideo) {
          await _videoController.initialize();
          await _videoController.play();
          await Future.delayed(_videoController.value.duration);
          _navigateTo(SelectLanguageScreen());
        } else if (state is SplashAuth) {
          _navigateTo(AuthScreen());
        }
      },
      builder: (_, state) {
        return Scaffold(
          body: AnimatedSwitcher(
            duration: _fadeDuration,
            child: state is SplashVideo ? _buildVideoPlayer() : _buildLogo(),
          ),
        );
      },
    );
  }

  Widget _buildVideoPlayer() {
    return _videoController.value.isInitialized
        ? VideoPlayer(_videoController)
        : const SizedBox.shrink();
  }

  Widget _buildLogo() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SplashLoadingIcon(),
          const SizedBox(height: 16.0),
          _buildLoadingStatus(),
        ],
      ),
    );
  }

  Widget _buildLoadingStatus() {
    return FadeTransition(
      opacity: _fadeAnimationController,
      child: Text(
        'Loading...',
        style: const TextStyle(
          color: AppColors.primaryTextColor,
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _navigateTo(Widget screen) {
    Navigator.of(context).pushReplacement(
      SlideWithFadeRoute(builder: (_) => screen),
    );
  }
}
