import 'dart:collection';

import 'package:flutter/material.dart';

const Duration _animationDuration = Duration(milliseconds: 250);

class ToastBuilder extends StatefulWidget {
  ToastBuilder({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  static _ToastBuilderState of(BuildContext context) =>
      context.findAncestorStateOfType<_ToastBuilderState>()!;

  @override
  _ToastBuilderState createState() => _ToastBuilderState();
}

class _ToastBuilderState extends State<ToastBuilder> {
  final ListQueue<_ToastEntry> _toastQueue = ListQueue();
  _ToastEntry? _currentToast;

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void showToast({
    required Widget child,
    required Duration duration,
    Curve curve = Curves.fastOutSlowIn,
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
    _toastQueue.add(_ToastEntry(
      duration: duration,
      entry: entry,
    ));

    _showToastFromQueue();
  }

  void _showToastFromQueue() async {
    if (_toastQueue.isNotEmpty && _currentToast == null) {
      final toast = _currentToast = _toastQueue.first;
      final state = Overlay.of(context);
      state?.insert(toast.entry);

      await Future.delayed(toast.duration + _animationDuration);

      _toastQueue.remove(toast);
      toast.entry.remove();
      _currentToast = null;

      _showToastFromQueue();
    }
  }
}

class _ToastEntry {
  const _ToastEntry({
    required this.duration,
    required this.entry,
  });

  final Duration duration;
  final OverlayEntry entry;
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
