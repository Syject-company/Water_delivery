import 'package:flutter/material.dart';

extension NavigatorHelper on GlobalKey<NavigatorState> {
  void pop<T extends Object?>([T? result]) {
    return this.currentState!.pop<T>();
  }

  Future<bool> maybePop<T extends Object?>([T? result]) {
    return this.currentState!.maybePop<T>(result);
  }

  Future<T?> pushNamed<T extends Object?>(String routeName,
      {Object? arguments}) {
    return this.currentState!.pushNamed<T>(routeName, arguments: arguments);
  }
}
