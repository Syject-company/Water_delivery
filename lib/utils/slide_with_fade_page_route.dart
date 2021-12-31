import 'package:flutter/material.dart';

class SlideWithFadePageRoute<T> extends MaterialPageRoute<T> {
  SlideWithFadePageRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
  }) : super(builder: builder, settings: settings);

  @override
  Duration get transitionDuration => Duration(milliseconds: 250);

  @override
  Duration get reverseTransitionDuration => Duration(milliseconds: 250);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final Offset offset;
    switch (Directionality.of(context)) {
      case TextDirection.rtl:
        offset = Offset(-0.15, 0.0);
        break;
      case TextDirection.ltr:
        offset = Offset(0.15, 0.0);
        break;
    }

    return SlideTransition(
      position: animation.drive(
        Tween<Offset>(begin: offset, end: Offset.zero)
            .chain(CurveTween(curve: Curves.fastOutSlowIn)),
      ),
      child: FadeTransition(
        opacity: animation.drive(
          Tween<double>(begin: 0.0, end: 1.0)
              .chain(CurveTween(curve: Curves.fastOutSlowIn)),
        ),
        child: child,
      ),
    );
  }
}
