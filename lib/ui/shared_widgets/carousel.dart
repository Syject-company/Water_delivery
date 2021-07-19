import 'dart:async';

import 'package:flutter/material.dart';

const int _maxItems = 1000000;
const int _centerItem = 500000;

class CarouselSlider extends StatefulWidget {
  CarouselSlider({Key? key}) : super(key: key);

  final List<Widget> items = [
    ClipRRect(
      borderRadius: BorderRadius.circular(18.0),
      child: Image.asset(
        'assets/images/banner_1.jpg',
        fit: BoxFit.fill,
        filterQuality: FilterQuality.high,
      ),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(18.0),
      child: Image.asset(
        'assets/images/banner_2.jpg',
        fit: BoxFit.fill,
        filterQuality: FilterQuality.high,
      ),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(18.0),
      child: Image.asset(
        'assets/images/shrink_wrap_500ml_v1.png',
        fit: BoxFit.fill,
        filterQuality: FilterQuality.high,
      ),
    ),
  ];

  @override
  _CarouselSliderState createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSlider> {
  late final Map<int, Widget> items;
  final PageController _pageController =
      // TODO: fraction
      PageController(initialPage: _centerItem, viewportFraction: 0.75);
  Timer? timer;

  @override
  void initState() {
    super.initState();
    items = widget.items.asMap();
    _handleAutoPlay();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / (290 / 153) * 0.75,
      child: PageView.builder(
        itemCount: _maxItems,
        controller: _pageController,
        itemBuilder: (context, index) => items.entries
            .firstWhere((entry) => index % items.length == entry.key)
            .value,
      ),
    );
  }

  Timer? _getTimer() {
    return Timer.periodic(Duration(seconds: 5), (_) {
      _pageController.nextPage(
          duration: Duration(milliseconds: 750), curve: Curves.fastOutSlowIn);
    });
  }

  void _clearTimer() {
    if (timer != null) {
      timer?.cancel();
      timer = null;
    }
  }

  void _resumeTimer() {
    if (timer == null) {
      timer = _getTimer();
    }
  }

  void _handleAutoPlay() {
    if (timer != null) return;

    _clearTimer();
    _resumeTimer();
  }
}

class CarouselOptions {
  final double? height;
  final double aspectRatio;
  final double viewportFraction;
  final int initialPage;
  final bool enableInfiniteScroll;
  final bool reverse;
  final bool autoPlay;
  final Duration autoPlayInterval;
  final Duration autoPlayAnimationDuration;
  final Curve autoPlayCurve;
  final bool? enlargeCenterPage;
  final Axis scrollDirection;
  final Function(int index)? onPageChanged;
  final ValueChanged<double?>? onScrolled;
  final ScrollPhysics? scrollPhysics;
  final bool pageSnapping;
  final bool pauseAutoPlayOnTouch;
  final bool pauseAutoPlayOnManualNavigate;
  final bool pauseAutoPlayInFiniteScroll;

  CarouselOptions({
    this.height,
    this.aspectRatio = 16 / 9,
    this.viewportFraction = 0.8,
    this.initialPage = 0,
    this.enableInfiniteScroll = true,
    this.reverse = false,
    this.autoPlay = false,
    this.autoPlayInterval = const Duration(seconds: 5),
    this.autoPlayAnimationDuration = const Duration(milliseconds: 750),
    this.autoPlayCurve = Curves.fastOutSlowIn,
    this.enlargeCenterPage = false,
    this.onPageChanged,
    this.onScrolled,
    this.scrollPhysics,
    this.pageSnapping = true,
    this.scrollDirection = Axis.horizontal,
    this.pauseAutoPlayOnTouch = true,
    this.pauseAutoPlayOnManualNavigate = true,
    this.pauseAutoPlayInFiniteScroll = false,
  });
}
