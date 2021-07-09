import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:water/bloc/splash/splash_cubit.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/splash/widgets/splash_loading_icon.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const String _splashVideoPath = 'assets/video/splash_video.mp4';

  late final VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController =
        VideoPlayerController.asset(_splashVideoPath)
          ..addListener(() => setState(() {}))
          ..initialize().then((_) async {
            await Future.delayed(_videoController.value.duration);
            // TODO: load select language screen
          })
          ..play();
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SplashCubit, SplashState>(
        builder: (_, state) {
          if (state is SplashVideo) {}

          return AnimatedSwitcher(
            duration: Duration(milliseconds: 350),
            child: state is SplashVideo
                ? _buildVideoPlayer()
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _buildLoadingIcon(),
                        const SizedBox(height: 16.0),
                        _buildLoadingText(state),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return _videoController.value.isInitialized
        ? VideoPlayer(_videoController)
        : const SizedBox.shrink();
  }

  Widget _buildLoadingIcon() {
    return const SplashLoadingIcon(
      color: AppColors.splashIconColor,
      fillColor: AppColors.primaryColor,
    );
  }

  Widget _buildLoadingText(SplashState state) {
    return BlocBuilder<SplashCubit, SplashState>(
      builder: (_, state) {
        final loadingStatus = state is SplashLoading ? 'Loading...' : '';

        return Text(
          loadingStatus,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: AppColors.primaryTextColor,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
  }
}
