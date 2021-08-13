import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

part 'carousel_options.dart';

const int _itemCount = 10000000;
const int _centerItem = _itemCount >> 1;
const PageScrollPhysics _pageScrollPhysics = PageScrollPhysics();

class CarouselSlider extends StatefulWidget {
  CarouselSlider({
    Key? key,
    required this.options,
    required this.items,
  }) : super(key: key);

  final CarouselOptions options;
  final List<Widget> items;

  @override
  _CarouselSliderState createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSlider> {
  late PageController _pageController;
  late int _lastReportedPage;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.options.autoPlay) {
      _startAutoPlayCarousel();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.options.infiniteScroll) {
      _pageController = PageController(
        viewportFraction: widget.options.viewportFraction,
        initialPage: _centerItem,
      );
      _lastReportedPage = _centerItem;
    } else {
      _pageController = PageController(
        viewportFraction: widget.options.viewportFraction,
        initialPage: 0,
      );
      _lastReportedPage = 0;
    }

    final height = widget.options.height ?? _calculateHeight();
    final axisDirection = _getDirection(context);
    final physics = _ForceImplicitScrollPhysics(
      allowImplicitScrolling: widget.options.allowImplicitScrolling,
    ).applyTo(widget.options.pageSnapping
        ? _pageScrollPhysics.applyTo(widget.options.scrollPhysics)
        : widget.options.scrollPhysics);

    return SizedBox(
      height: height,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.depth == 0 &&
              widget.options.onPageChanged != null &&
              notification is ScrollUpdateNotification) {
            final metrics = notification.metrics as PageMetrics;
            final currentPage = metrics.page!.round();
            if (currentPage != _lastReportedPage) {
              _lastReportedPage = currentPage;
              widget.options.onPageChanged!(currentPage);
            }
          }
          return false;
        },
        child: Scrollable(
          dragStartBehavior: DragStartBehavior.start,
          axisDirection: axisDirection,
          controller: _pageController,
          physics: physics,
          viewportBuilder: (context, position) {
            return Viewport(
              cacheExtent: widget.options.allowImplicitScrolling ? 1.0 : 0.0,
              cacheExtentStyle: CacheExtentStyle.viewport,
              axisDirection: axisDirection,
              offset: position,
              slivers: [
                SliverFillViewport(
                  viewportFraction: _pageController.viewportFraction,
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _wrapItem(
                        widget.items.asMap()[index % widget.items.length]),
                    childCount: widget.options.infiniteScroll
                        ? _itemCount
                        : widget.items.length,
                  ),
                  padEnds: widget.options.alignCenter,
                ),
              ],
            );
          },
        ),
      ), // child: PageView.builder(
    );
  }

  Widget _wrapItem(Widget? item) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.options.scrollDirection == Axis.horizontal
            ? widget.options.spaceBetween / 2
            : 0.0,
        vertical: widget.options.scrollDirection == Axis.vertical
            ? widget.options.spaceBetween / 2
            : 0.0,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.options.borderRadius),
        child: item ?? const SizedBox.shrink(),
      ),
    );
  }

  AxisDirection _getDirection(BuildContext context) {
    switch (widget.options.scrollDirection) {
      case Axis.horizontal:
        final textDirection = Directionality.of(context);
        final axisDirection = textDirectionToAxisDirection(textDirection);
        return widget.options.reverse
            ? flipAxisDirection(axisDirection)
            : axisDirection;
      case Axis.vertical:
        return widget.options.reverse ? AxisDirection.up : AxisDirection.down;
    }
  }

  double _calculateHeight() {
    return ((MediaQuery.of(context).size.width / widget.options.aspectRatio) *
            widget.options.viewportFraction) -
        (widget.options.spaceBetween / 2);
  }

  void _startAutoPlayCarousel() {
    if (_timer == null) {
      _timer = Timer.periodic(
        widget.options.autoPlayInterval,
        (_) {
          if (!widget.options.infiniteScroll &&
              (_pageController.page! / widget.options.viewportFraction)
                      .floor() ==
                  widget.items.length - 1) {
            _pageController.animateToPage(
              0,
              duration: widget.options.autoPlayAnimationDuration,
              curve: widget.options.autoPlayCurve,
            );
          } else {
            _pageController.nextPage(
              duration: widget.options.autoPlayAnimationDuration,
              curve: widget.options.autoPlayCurve,
            );
          }
        },
      );
    }
  }
}

class _ForceImplicitScrollPhysics extends ScrollPhysics {
  const _ForceImplicitScrollPhysics({
    required this.allowImplicitScrolling,
    ScrollPhysics? parent,
  }) : super(parent: parent);

  @override
  _ForceImplicitScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return _ForceImplicitScrollPhysics(
      allowImplicitScrolling: allowImplicitScrolling,
      parent: buildParent(ancestor),
    );
  }

  @override
  final bool allowImplicitScrolling;
}
