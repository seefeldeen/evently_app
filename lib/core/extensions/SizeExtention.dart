import 'package:events/main.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart'; // Import the file where navigatorKey is defined

extension Responsive on num {
  double get h {
    return MediaQuery.of(navigatorKey.currentContext!).size.height * this;
  }

  double get w {
    return MediaQuery.of(navigatorKey.currentContext!).size.width * this;
  }
}
