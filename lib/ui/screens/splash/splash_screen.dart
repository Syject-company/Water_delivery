import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';
import 'package:water/bloc/splash/splash_bloc.dart';
import 'package:water/main.dart';
import 'package:water/ui/constants/paths.dart';
import 'package:water/ui/shared_widgets/water.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final VideoPlayerController _videoController =
      VideoPlayerController.asset(Paths.splash_video);

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    _videoController.addListener(() => setState(() {}));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ResponsiveUtils.setMediaQuery(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      listener: (_, state) async {
        if (state is ImagesPreloaded) {
          await Future.wait([
            precachePicture(
              ExactAssetPicture(SvgPicture.svgStringDecoder, Paths.logo_icon),
              context,
            ),
            precachePicture(
              ExactAssetPicture(
                  SvgPicture.svgStringDecoder, Paths.logo_label_white),
              context,
            ),
            precachePicture(
              ExactAssetPicture(
                  SvgPicture.svgStringDecoder, Paths.logo_label_colored),
              context,
            ),
          ]);

          await Future.wait(state.images.map((image) {
            return precacheImage(CachedNetworkImageProvider(image), context);
          }));

          context.splash.add(Loading());
        }
        if (state is SplashLoading) {
          await _videoController.initialize();
          await _videoController.play();

          context.splash.add(LoadVideo());
        } else if (state is SplashVideo) {
          await Future.delayed(_videoController.value.duration);

          appNavigator.pushReplacementNamed(
            state.firstLaunch ? AppRoutes.selectLanguage : AppRoutes.home,
          );
        }
      },
      builder: (_, state) {
        return Scaffold(
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 375),
            reverseDuration: const Duration(milliseconds: 375),
            switchInCurve: Curves.fastOutSlowIn,
            switchOutCurve: Curves.fastOutSlowIn,
            child: state is SplashVideo ? _buildVideo() : _buildLogo(),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  Widget _buildVideo() {
    return VideoPlayer(_videoController);
  }

  Widget _buildLogo() {
    return SafeArea(
      child: Center(
        child: WaterAnimatedLogo(
          widthFactor: 4.5,
        ),
      ),
    );
  }
}
