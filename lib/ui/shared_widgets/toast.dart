import 'package:flutter/material.dart';

class Toast {
  static void showToast(
    BuildContext context, {
    required Widget child,
    required Duration duration,
    Curve curve = Curves.linear,
  }) async {
    final toast = ToastEntry(
      duration: duration,
      child: child,
    );
    final entry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: 24 + 72.0,
          left: 12.0,
          right: 12.0,
          child: toast,
        );
      },
    );

    final state = Overlay.of(context);
    state?.insert(entry);

    await Future.delayed(duration + Duration(milliseconds: 375));

    entry.remove();
  }
}

class ToastEntry extends StatefulWidget {
  const ToastEntry({
    Key? key,
    required this.duration,
    required this.child,
  }) : super(key: key);

  final Duration duration;
  final Widget child;

  @override
  _ToastEntryState createState() => _ToastEntryState();
}

class _ToastEntryState extends State<ToastEntry>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final CurvedAnimation _curvedAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 375),
      vsync: this,
    )
      ..addListener(() => setState(() {}))
      ..forward();
    _curvedAnimation = CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOutCubic);

    Future.delayed(widget.duration, () {
      _animationController.reverse();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _curvedAnimation,
      child: SlideTransition(
        position:
            Tween<Offset>(begin: Offset(0.0, -0.25), end: Offset(0.0, 0.0))
                .animate(_curvedAnimation),
        child: widget.child,
      ),
    );
  }
}
