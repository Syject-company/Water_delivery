import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:water/bloc/splash/splash_bloc.dart';
import 'package:water/ui/constants/paths.dart';
import 'package:water/ui/screens/router.dart';
import 'package:water/ui/shared_widgets/logo/animated_logo.dart';
import 'package:water/util/session.dart';

import 'pages/select_language.dart';

const Duration _fadeDuration = Duration(milliseconds: 375);
const Duration _pageSwapDuration = Duration(milliseconds: 375);

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final VideoPlayerController _videoController =
  VideoPlayerController.asset(Paths.splashVideo);
  final PageController _pageController = PageController();

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
      listener: (_, state) async {
        if (state is SplashLoading) {
          await _videoController.initialize();
          await _videoController.play();

          context.splash.add(LoadVideo());
        } else if (state is SplashVideo) {
          await Future.delayed(_videoController.value.duration);

          if (state.firstLaunch) {
            _pageController.nextPage(
              duration: _pageSwapDuration,
              curve: Curves.easeInOutCubic,
            );
          } else {
            Navigator.of(context).pushReplacementNamed(
                Session.isActive ? AppRoutes.home : AppRoutes.auth);
          }
        }
      },
      builder: (_, state) {
        return Scaffold(
          body: AnimatedSwitcher(
            duration: _fadeDuration,
            reverseDuration: _fadeDuration,
            switchInCurve: Curves.easeInOutCubic,
            switchOutCurve: Curves.easeInOutCubic,
            child: state is SplashVideo ? _buildPageView() : _buildLogo(),
          ),
        );
      },
    );
  }

  Widget _buildPageView() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: <Widget>[
        VideoPlayer(_videoController),
        const SelectLanguagePage(),
      ],
    );
  }

  Widget _buildLogo() {
    return const SafeArea(
      child: Center(
        child: WaterAnimatedLogo(),
      ),
    );
  }
}
