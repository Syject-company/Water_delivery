import 'package:flutter/material.dart';

extension NavigatorHelper on GlobalKey<NavigatorState> {
  void pop<T extends Object?>([T? result]) {
    return this.currentState!.pop<T>(result);
  }

  Future<bool> maybePop<T extends Object?>([T? result]) {
    return this.currentState!.maybePop<T>(result);
  }

  Future<T?> push<T extends Object?>(Route<T> route) {
    return this.currentState!.push<T>(route);
  }

  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return this.currentState!.pushNamed<T>(
          routeName,
          arguments: arguments,
        );
  }

  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return this.currentState!.pushReplacementNamed<T, TO>(
          routeName,
          arguments: arguments,
        );
  }
}
