part of '../animation.dart';

class SlideUp extends StatefulWidget {
  const SlideUp({
    Key? key,
    required this.child,
    this.duration,
    this.curve,
    this.offset,
  }) : super(key: key);

  final Widget child;
  final Duration? duration;
  final Curve? curve;
  final double? offset;

  @override
  _SlideUpState createState() => _SlideUpState();
}

class _SlideUpState extends State<SlideUp> with SingleTickerProviderStateMixin {
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
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0.0, widget.offset ?? 1.0),
            end: Offset.zero,
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
