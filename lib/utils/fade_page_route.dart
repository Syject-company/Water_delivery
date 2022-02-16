import 'package:flutter/material.dart';

class FadePageRoute<T> extends MaterialPageRoute<T> {
  FadePageRoute({
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
    return FadeTransition(
      opacity: animation.drive(
        Tween<double>(begin: 0.0, end: 1.0).chain(
          CurveTween(curve: Curves.fastOutSlowIn),
        ),
      ),
      child: child,
    );
  }
}
