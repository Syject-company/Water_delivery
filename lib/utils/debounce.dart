import 'dart:async';

import 'package:flutter/material.dart';

class Debounce {
  Debounce(this.delay);

  final Duration delay;

  Timer? _timer;

  call(VoidCallback callback) {
    _timer?.cancel();
    _timer = Timer(delay, callback);
  }

  dispose() {
    _timer?.cancel();
  }
}
