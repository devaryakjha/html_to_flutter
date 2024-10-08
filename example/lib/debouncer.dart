import 'dart:async';

import 'package:flutter/material.dart';

final class Debouncer<T> {
  Debouncer({
    required this.duration,
    this.onValue,
  });

  final Duration duration;
  final ValueChanged<T>? onValue;

  Timer? _timer;

  void call(T val) {
    _timer?.cancel();
    _timer = Timer(duration, () {
      onValue?.call(val);
    });
  }

  void dispose() {
    _timer?.cancel();
  }
}
