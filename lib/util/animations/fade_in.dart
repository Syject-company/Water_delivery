part of '../animation.dart';

class FadeIn extends StatefulWidget {
  const FadeIn({
    Key? key,
    required this.child,
    this.duration,
    this.curve,
  }) : super(key: key);

  final Widget child;
  final Duration? duration;
  final Curve? curve;

  @override
  _FadeInState createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration ?? _defaultDuration,
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return FadeTransition(
          opacity: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: _controller,
              curve: widget.curve ?? _defaultCurve,
            ),
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
