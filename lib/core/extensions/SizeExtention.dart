import 'package:events/main.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart'; // Import the file where navigatorKey is defined

extension Responsive on num {
  double get h {
    return MediaQuery.of(navigatorkey.currentContext!).size.height * this;
  }

  double get w {
    return MediaQuery.of(navigatorkey.currentContext!).size.width * this;
  }
}
