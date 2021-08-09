import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';

typedef DrawerCallback = void Function(bool);

const double _maxOffset = 0.9;
const double _velocity = 1.0;
const double _elevation = 8.0;
const double _maxWidth = 372.0;
const double _minFlingVelocity = 365.0;
const Duration _settleDuration = Duration(milliseconds: 250);

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
    required this.menu,
    required this.child,
    this.tapToClose = true,
    this.enableOpenDragGesture = true,
    this.drawerCallback,
  }) : super(key: key);

  /// The widget which determines menu actions.
  final Widget menu;

  /// The widget below this widget in the tree.
  final Widget child;

  /// Determines if the [SideMenu] can be closed with a tap on child.
  ///
  /// By default, the tap on child is enabled.
  final bool tapToClose;

  /// Determines if the [SideMenu] can be opened with a drag gesture.
  ///
  /// By default, the drag gesture is enabled.
  final bool enableOpenDragGesture;

  /// Optional callback that is called when a [SideMenu] is opened or closed.
  final DrawerCallback? drawerCallback;

  static SideMenuState of(BuildContext context) =>
      context.findAncestorStateOfType<SideMenuState>()!;

  @override
  SideMenuState createState() => SideMenuState();
}

class SideMenuState extends State<SideMenu>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _previouslyOpened = false;

  bool get isOpened => _controller.value > 0.5;

  double get _width => MediaQuery.of(context).size.width;

  double get _height => MediaQuery.of(context).size.height;

  double get _offset =>
      _width * _maxOffset > _maxWidth ? _maxWidth / _width : _maxOffset;

  double get _widthWithOffset => _width * _offset;

  AlignmentDirectional get _drawerInnerAlignment =>
      AlignmentDirectional.centerStart;

  AlignmentDirectional get _drawerOuterAlignment =>
      AlignmentDirectional.centerEnd;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: _settleDuration,
      vsync: this,
      value: 0.0,
    )
      ..addListener(() => setState(() {}))
      ..addStatusListener(_animationStatusChanged);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widthFactor = 1.0 - (_controller.value * _offset);

    return Stack(
      alignment: _drawerInnerAlignment,
      children: <Widget>[
        GestureDetector(
          onHorizontalDragDown:
              widget.enableOpenDragGesture ? _handleDragDown : null,
          onHorizontalDragUpdate: widget.enableOpenDragGesture ? _move : null,
          onHorizontalDragEnd: widget.enableOpenDragGesture ? _settle : null,
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
                _buildMenu(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void open() {
    _controller.fling(velocity: _velocity);
  }

  void close() {
    _controller.fling(velocity: -_velocity);
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
    return !_controller.isDismissed
        ? GestureDetector(
            onTap: widget.tapToClose || !widget.enableOpenDragGesture
                ? close
                : null,
            child: Container(
              color: ColorTween(
                begin: AppColors.transparent,
                end: AppColors.black.withOpacity(0.25),
              ).evaluate(_controller),
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _buildMenu() {
    final double dx;
    switch (Directionality.of(context)) {
      case TextDirection.rtl:
        dx = _widthWithOffset - (_controller.value * _widthWithOffset);
        break;
      case TextDirection.ltr:
        dx = (_controller.value * _widthWithOffset) - _widthWithOffset;
        break;
    }

    return Transform.translate(
      offset: Offset(dx, 0.0),
      child: SizedBox(
        width: _widthWithOffset,
        height: _height,
        child: Material(
          elevation: _controller.value * _elevation,
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
          widget.drawerCallback?.call(isOpened);
          _previouslyOpened = isOpened;
        }
        break;
      case AnimationStatus.completed:
        if (_previouslyOpened != isOpened) {
          widget.drawerCallback?.call(isOpened);
          _previouslyOpened = isOpened;
        }
    }
  }

  void _handleDragDown(DragDownDetails details) {
    _controller.stop();
  }

  void _move(DragUpdateDetails details) {
    final delta = details.primaryDelta! / _width;
    switch (Directionality.of(context)) {
      case TextDirection.rtl:
        _controller.value -= delta;
        break;
      case TextDirection.ltr:
        _controller.value += delta;
        break;
    }
  }

  void _settle(DragEndDetails details) {
    if (_controller.isDismissed) {
      return;
    }

    if (details.velocity.pixelsPerSecond.dx.abs() >= _minFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx / _width;
      switch (Directionality.of(context)) {
        case TextDirection.rtl:
          _controller.fling(velocity: -visualVelocity);
          break;
        case TextDirection.ltr:
          _controller.fling(velocity: visualVelocity);
          break;
      }
    } else {
      _controller.value > 0.5 ? open() : close();
    }
  }
}
