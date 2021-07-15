import 'package:flutter/material.dart';

import 'logo/animated_logo.dart';

class Loader extends StatefulWidget {
  const Loader({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.child,
        _buildLogo(),
      ],
    );
  }

  Widget _buildLogo() {
    return Container(
      color: Colors.white.withOpacity(0.75),
      child: Center(
        child: const AnimatedLogo(),
      ),
    );
  }
}
