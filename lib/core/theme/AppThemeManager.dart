import 'package:events/core/ColorPallete/colorpallete.dart';
import 'package:flutter/material.dart';

class AppThemeManager {
  AppThemeManager._();

  static ThemeData lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      actionsIconTheme: IconThemeData(color: colorpallete.parimary),
        backgroundColor: colorpallete.darkblue, centerTitle: true)
    ,
    scaffoldBackgroundColor: colorpallete.parimary,
    primaryColor: colorpallete.parimary,
    primaryColorDark: Colors.black,
    primaryColorLight: Colors.white,

   floatingActionButtonTheme: const FloatingActionButtonThemeData(
     shape: CircleBorder(
         side: BorderSide(color: Colors.white, width: 5)),
      backgroundColor: colorpallete.darkblue,
      foregroundColor: colorpallete.darkblue,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: colorpallete.darkblue,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.white,

    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.grey)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.grey)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.grey)),
    ),
    textTheme: const TextTheme(
        bodySmall: TextStyle(color: Colors.black, fontSize: 14),
        bodyMedium: TextStyle(color: Colors.black, fontSize: 16),
        bodyLarge: TextStyle(color: Colors.black, fontSize: 18)),
  );




  static ThemeData darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      actionsIconTheme: IconThemeData(color: colorpallete.darkblue),
      iconTheme: IconThemeData(color: colorpallete.darkblue),
        color: colorpallete.darkTHEMR,
        centerTitle: true),
    scaffoldBackgroundColor: colorpallete.darkTHEMR,
    primaryColor: colorpallete.parimary,
    primaryColorDark: Colors.white,
    primaryColorLight: Colors.white,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: colorpallete.darkTHEMR,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.white,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: colorpallete.darkTHEMR,
      foregroundColor: colorpallete.parimary,
      shape: CircleBorder(
          side: BorderSide(color: colorpallete.parimary, width: 5)),
    ),
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: colorpallete.parimary)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: colorpallete.parimary)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: colorpallete.parimary))),
    textTheme: const TextTheme(
        bodySmall: TextStyle(color: colorpallete.parimary, fontSize: 14),
        bodyMedium: TextStyle(color: colorpallete.parimary, fontSize: 16),
        bodyLarge: TextStyle(color: colorpallete.parimary, fontSize: 18)),
  );
}
