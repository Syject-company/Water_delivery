import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:water/bloc/splash/splash_bloc.dart';
import 'package:water/ui/screens/auth/auth_screen.dart';
import 'package:water/ui/screens/select_language/select_language_screen.dart';
import 'package:water/ui/shared_widgets/logo/animated_logo.dart';
import 'package:water/ui/shared_widgets/text/label.dart';
import 'package:water/util/local_storage.dart';
import 'package:water/util/slide_with_fade_route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  static const String _splashVideoPath = 'assets/video/splash_video.mp4';
  static const Duration _scaleDuration = Duration(milliseconds: 375);

  late final AnimationController _scaleAnimationController;

  final VideoPlayerController _videoController =
      VideoPlayerController.asset(_splashVideoPath);

  @override
  void initState() {
    super.initState();
    _scaleAnimationController = AnimationController(
      duration: _scaleDuration,
      vsync: this,
    )..forward();
    _videoController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _scaleAnimationController.dispose();
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

          await Future.delayed(_videoController.value.duration);

          if (state.firstLaunch) {
            _navigateTo(SelectLanguageScreen());
          } else {
            _navigateTo(AuthScreen());
          }
        }
      },
      builder: (_, state) {
        return Scaffold(
          body: AnimatedSwitcher(
            duration: _scaleDuration,
            child: state is SplashVideo ? _buildVideoPlayer() : _buildLogo(),
          ),
        );
      },
    );
  }

  Widget _buildVideoPlayer() {
    return VideoPlayer(_videoController);
  }

  Widget _buildLogo() {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const AnimatedLogo(),
            const SizedBox(height: 16.0),
            _buildLoadingStatus(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingStatus() {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: _scaleAnimationController,
        curve: Curves.easeInOutCubic,
      ),
      child: Label(
        'Loading...',
        fontSize: 24.0,
      ),
    );
  }

  void _navigateTo(Widget screen) {
    Navigator.of(context).pushReplacement(
      SlideWithFadeRoute(builder: (_) => screen),
    );
  }
}
