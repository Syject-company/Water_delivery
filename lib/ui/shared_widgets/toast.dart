import 'dart:collection';

import 'package:flutter/material.dart';

const Duration _animationDuration = Duration(milliseconds: 250);

class Toast {
  static final ListQueue<_ToastEntry> _toastQueue = ListQueue();
  static _ToastEntry? _currentToast;

  static void showToast(
    BuildContext context, {
    required Widget child,
    required Duration duration,
    Curve curve = Curves.easeInOutCubic,
  }) async {
    final entry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: 12.0,
          left: 12.0,
          right: 12.0,
          child: _ToastWidget(
            duration: duration,
            curve: curve,
            child: child,
          ),
        );
      },
    );
    _toastQueue.add(_ToastEntry(entry: entry, duration: duration));

    _showToastFromQueue(context);
  }

  static void _showToastFromQueue(BuildContext context) async {
    if (_toastQueue.isNotEmpty && _currentToast == null) {
      final toast = _currentToast = _toastQueue.first;
      final state = Overlay.of(context);
      state?.insert(toast.entry);

      await Future.delayed(toast.duration + _animationDuration);

      _toastQueue.remove(toast);
      toast.entry.remove();
      _currentToast = null;

      _showToastFromQueue(context);
    }
  }
}

class _ToastEntry {
  const _ToastEntry({
    required this.entry,
    required this.duration,
  });

  final OverlayEntry entry;
  final Duration duration;
}

class _ToastWidget extends StatefulWidget {
  const _ToastWidget({
    Key? key,
    required this.duration,
    required this.child,
    required this.curve,
  }) : super(key: key);

  final Duration duration;
  final Widget child;
  final Curve curve;

  @override
  _ToastWidgetState createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Offset> _positionAnimation;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: _animationDuration,
      vsync: this,
    )
      ..addListener(() => setState(() {}))
      ..forward();
    _positionAnimation = Tween<Offset>(
      begin: Offset(0.0, -0.25),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: widget.curve,
    ));
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: widget.curve,
    ));

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
    return SafeArea(
      child: SlideTransition(
        position: _positionAnimation,
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: widget.child,
        ),
      ),
    );
  }
}
