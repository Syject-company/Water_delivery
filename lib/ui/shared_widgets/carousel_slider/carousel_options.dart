part of 'carousel_slider.dart';

class CarouselOptions {
  CarouselOptions({
    this.height,
    this.onPageChanged,
    this.scrollPhysics,
    this.spaceBetween = 0.0,
    this.borderRadius = 18.0,
    this.aspectRatio = 16 / 9,
    this.viewportFraction = 1.0,
    this.infiniteScroll = true,
    this.reverse = false,
    this.autoPlay = true,
    this.autoPlayInterval = const Duration(seconds: 5),
    this.autoPlayAnimationDuration = const Duration(milliseconds: 750),
    this.autoPlayCurve = Curves.fastOutSlowIn,
    this.scrollDirection = Axis.horizontal,
    this.allowImplicitScrolling = false,
    this.pageSnapping = true,
    this.alignCenter = false,
  });

  final double? height;
  final Function(int index)? onPageChanged;
  final ScrollPhysics? scrollPhysics;
  final double spaceBetween;
  final double borderRadius;
  final double aspectRatio;
  final double viewportFraction;
  final bool infiniteScroll;
  final bool reverse;
  final bool autoPlay;
  final Duration autoPlayInterval;
  final Duration autoPlayAnimationDuration;
  final Curve autoPlayCurve;
  final Axis scrollDirection;
  final bool allowImplicitScrolling;
  final bool pageSnapping;
  final bool alignCenter;
}