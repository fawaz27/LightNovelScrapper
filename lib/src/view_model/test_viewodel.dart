import 'package:flutter/foundation.dart';

class TestProvider {
  int _x = 0;
  // ignore: recursive_getters
  int get x => x;
  void increment() {
    _x++;
    if (kDebugMode) {
      print("current value of x is $_x");
    }
  }
}
