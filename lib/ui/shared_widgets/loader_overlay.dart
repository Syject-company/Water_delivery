import 'package:flutter/material.dart';

import 'logo/animated_logo.dart';

const Color _backgroundColor = Color.fromRGBO(255, 255, 255, 0.75);
const Duration _fadeDuration = Duration(milliseconds: 125);

extension LoaderOverlayGetter on BuildContext {
  void showLoader() => LoaderOverlay.of(this).showLoader();

  void hideLoader() => LoaderOverlay.of(this).hideLoader();
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
      children: <Widget>[
        widget.child,
        AnimatedSwitcher(
          duration: _fadeDuration,
          child: _showLoader ? _buildLogo() : const SizedBox.shrink(),
        ),
      ],
    );
  }

  void showLoader() {
    setState(() => _showLoader = true);
  }

  void hideLoader() {
    setState(() => _showLoader = false);
  }

  Widget _buildLogo() {
    return Container(
      color: _backgroundColor,
      child: const Center(
        child: AnimatedLogo(),
      ),
    );
  }
}
