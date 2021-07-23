import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:water/ui/constants/colors.dart';

typedef InnerDrawerCallback = void Function(bool);
typedef InnerDragUpdateCallback = void Function(double);

const double _offset = 0.9;
const double _velocity = 1.0;
const double _elevation = 16.0;
const double _minFlingVelocity = 365.0;
const Duration _settleDuration = Duration(milliseconds: 350);

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
    required this.menu,
    required this.child,
    this.onTapClose = false,
    this.swipe = true,
    this.backgroundDecoration,
    this.innerDrawerCallback,
  }) : super(key: key);

  final Widget menu;
  final Widget child;
  final bool onTapClose;
  final bool swipe;
  final Decoration? backgroundDecoration;
  final InnerDrawerCallback? innerDrawerCallback;

  @override
  SideMenuState createState() => SideMenuState();
}

class SideMenuState extends State<SideMenu>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  final FocusScopeNode _focusScopeNode = FocusScopeNode();

  LocalHistoryEntry? _historyEntry;
  bool _previouslyOpened = false;

  bool get isOpened => _animationController.value < 0.5;

  double get _width => MediaQuery.of(context).size.width;

  AlignmentDirectional get _drawerInnerAlignment =>
      AlignmentDirectional.centerStart;

  AlignmentDirectional get _drawerOuterAlignment =>
      AlignmentDirectional.centerEnd;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: _settleDuration,
      vsync: this,
      value: 1.0,
    )
      ..addListener(() => setState(() {}))
      ..addStatusListener(_animationStatusChanged);
  }

  @override
  void dispose() {
    _historyEntry?.remove();
    _animationController.dispose();
    _focusScopeNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final offset = 1.0 - _offset * 1.0;
    final widthFactor = (_animationController.value * (1.0 - offset)) + offset;

    return Stack(
      alignment: _drawerInnerAlignment,
      children: <Widget>[
        GestureDetector(
          onTap: () {},
          onHorizontalDragDown: widget.swipe ? _handleDragDown : null,
          onHorizontalDragUpdate: widget.swipe ? _move : null,
          onHorizontalDragEnd: widget.swipe ? _settle : null,
          excludeFromSemantics: true,
          child: RepaintBoundary(
            child: Stack(
              children: [
                Align(
                  alignment: _drawerOuterAlignment,
                  child: Align(
                    alignment: _drawerInnerAlignment,
                    widthFactor: widthFactor,
                    child: RepaintBoundary(
                      child: _buildChild(),
                    ),
                  ),
                ),
                FocusScope(
                  node: _focusScopeNode,
                  child: _buildMenu(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void open() {
    _animationController.fling(velocity: -_velocity);
  }

  void close() {
    _animationController.fling(velocity: _velocity);
  }

  void toggle() {
    _previouslyOpened ? close() : open();
  }

  Widget _buildChild() {
    return Stack(
      children: <Widget>[
        widget.child,
        _buildBackdrop(),
      ],
    );
  }

  Widget _buildBackdrop() {
    return !_animationController.isCompleted
        ? GestureDetector(
            onTap: widget.onTapClose || !widget.swipe ? close : null,
            child: Container(
              color: ColorTween(begin: Colors.black54, end: Colors.transparent)
                  .evaluate(_animationController),
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _buildMenu() {
    return Transform.translate(
      offset: Offset(-_width * _offset * _animationController.value, 0.0),
      child: SizedBox(
        width: _width * _offset,
        height: MediaQuery.of(context).size.height,
        child: Material(
          elevation: (1.0 - _animationController.value) * _elevation,
          color: AppColors.white,
          child: widget.menu,
        ),
      ),
    );
  }

  void _animationStatusChanged(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.reverse:
        break;
      case AnimationStatus.forward:
        break;
      case AnimationStatus.dismissed:
        if (_previouslyOpened != isOpened) {
          _previouslyOpened = isOpened;
          if (widget.innerDrawerCallback != null)
            widget.innerDrawerCallback!(isOpened);
        }
        break;
      case AnimationStatus.completed:
        if (_previouslyOpened != isOpened) {
          _previouslyOpened = isOpened;
          if (widget.innerDrawerCallback != null)
            widget.innerDrawerCallback!(isOpened);
        }
    }
  }

  void _handleDragDown(DragDownDetails details) {
    _animationController.stop();
  }

  void _move(DragUpdateDetails details) {
    double delta = -(details.primaryDelta! / _width);
    double offset = _offset;
    double ee = 1.0;

    offset = 1.0 - pow(offset / ee, 1.0 / 2.0);

    switch (Directionality.of(context)) {
      case TextDirection.rtl:
        _animationController.value -= delta + (delta * offset);
        break;
      case TextDirection.ltr:
        _animationController.value += delta + (delta * offset);
        break;
    }

    if (isOpened != _previouslyOpened && widget.innerDrawerCallback != null) {
      widget.innerDrawerCallback!(isOpened);
    }
    _previouslyOpened = isOpened;
  }

  void _settle(DragEndDetails details) {
    if (_animationController.isDismissed) {
      return;
    }

    if (details.velocity.pixelsPerSecond.dx.abs() >= _minFlingVelocity) {
      double visualVelocity =
          -(details.velocity.pixelsPerSecond.dx + _velocity) / _width;

      switch (Directionality.of(context)) {
        case TextDirection.rtl:
          _animationController.fling(velocity: -visualVelocity);
          break;
        case TextDirection.ltr:
          _animationController.fling(velocity: visualVelocity);
          break;
      }
    } else {
      isOpened ? open() : close();
    }
  }
}
