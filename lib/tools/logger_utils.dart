import 'dart:developer';

import 'package:flutter/foundation.dart';

mixin Logger {
  // Sample of abstract logging function
  static void print(dynamic msg) {
    if (kDebugMode) {
      log('^^^^^\n$msg\n^^^^^');
    }
  }
}
