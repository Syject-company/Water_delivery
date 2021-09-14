import 'package:flutter/material.dart';

class GradientIcon extends StatelessWidget {
  GradientIcon(
    this.icon, {
    required this.size,
    required this.color,
    required this.gradient,
  });

  final IconData icon;
  final double size;
  final Color color;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return gradient.createShader(bounds);
      },
      child: Icon(
        icon,
        size: size,
        color: color,
      ),
    );
  }
}
