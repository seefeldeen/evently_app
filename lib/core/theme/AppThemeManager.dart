import 'package:events/core/ColorPallete/colorpallete.dart';
import 'package:flutter/material.dart';

abstract class AppThemeManager {

  static ThemeData  lighttheme = ThemeData(
    scaffoldBackgroundColor: colorpallete.parimary,

    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontFamily: "Inter"
      ), titleMedium: TextStyle(
        fontFamily: "Inter"
      ), titleSmall: TextStyle(
        fontFamily: "Inter"
      ),
    ),
    appBarTheme: AppBarTheme(backgroundColor: colorpallete.parimary,
  iconTheme: IconThemeData(
  color: colorpallete.darkblue,)
    )
  );

}