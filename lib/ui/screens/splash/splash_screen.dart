import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:water/bloc/splash/splash_bloc.dart';
import 'package:water/ui/constants/paths.dart';
import 'package:water/ui/screens/router.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/session.dart';
import 'package:water/util/slide_with_fade_page_route.dart';

import 'select_language_screen.dart';

const Duration _fadeDuration = Duration(milliseconds: 375);

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final VideoPlayerController _videoController =
      VideoPlayerController.asset(Paths.splash_video);

  @override
  void initState() {
    super.initState();
    _videoController.addListener(() => setState(() {}));
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      listener: (context, state) async {
        if (state is SplashLoading) {
          await _videoController.initialize();
          await _videoController.play();

          context.splash.add(LoadVideo());
        } else if (state is SplashVideo) {
          await Future.delayed(_videoController.value.duration);

          if (state.firstLaunch) {
            Navigator.of(context).pushReplacement(
              SlideWithFadePageRoute(
                builder: (context) => SelectLanguageScreen(),
              ),
            );
          } else {
            Navigator.of(context).pushReplacementNamed(
              Session.isAuthenticated ? AppRoutes.home : AppRoutes.auth,
            );
            // Navigator.of(context).pushReplacementNamed(AppRoutes.home);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: AnimatedSwitcher(
            duration: _fadeDuration,
            reverseDuration: _fadeDuration,
            switchInCurve: Curves.fastOutSlowIn,
            switchOutCurve: Curves.fastOutSlowIn,
            child: state is SplashVideo ? _buildVideo() : _buildLogo(),
          ),
        );
      },
    );
  }

  Widget _buildVideo() {
    return VideoPlayer(_videoController);
  }

  Widget _buildLogo() {
    return const SafeArea(
      child: Center(child: WaterAnimatedLogo()),
    );
  }
}
