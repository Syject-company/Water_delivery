import 'package:flutter/material.dart';
import 'package:water/ui/shared_widgets/water.dart';

const Color _backgroundColor = Color.fromRGBO(255, 255, 255, 0.75);
const Duration _fadeDuration = Duration(milliseconds: 125);

extension LoaderOverlayGetter on BuildContext {
  void showLoader(bool show) {
    if (show) {
      LoaderOverlay.of(this).showLoader();
    } else {
      LoaderOverlay.of(this).hideLoader();
    }
  }
}

class LoaderOverlay extends StatefulWidget {
  const LoaderOverlay({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  static LoaderOverlayState of(BuildContext context) {
    return context.findAncestorStateOfType<LoaderOverlayState>()!;
  }

  @override
  LoaderOverlayState createState() => LoaderOverlayState();
}

class LoaderOverlayState extends State<LoaderOverlay> {
  bool _showLoader = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        AnimatedSwitcher(
          duration: _fadeDuration,
          child: _showLoader ? _buildLogo() : const SizedBox.shrink(),
        ),
      ],
    );
  }

  void showLoader() {
    if (!_showLoader) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        setState(() => _showLoader = true);
      });
    }
  }

  void hideLoader() {
    if (_showLoader) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        setState(() => _showLoader = false);
      });
    }
  }

  Widget _buildLogo() {
    return Container(
      color: _backgroundColor,
      child: Center(
        child: WaterAnimatedLogo(
          widthFactor: 4.5,
        ),
      ),
    );
  }
}
