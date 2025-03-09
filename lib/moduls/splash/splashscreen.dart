import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:events/core/constants/App_assets/Appassets.dart';
import 'package:events/core/extensions/SizeExtention.dart';
import 'package:events/moduls/onboardingscreens/onboareding1.dart';
import 'package:events/moduls/signin/FirstScreen.dart';
import 'package:flutter/material.dart';

class Splash_screen extends StatefulWidget {
  const Splash_screen({super.key});

  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, 'first');
    });
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context);
    return Scaffold(
      body:  AnimatedSplashScreen(
      backgroundColor: Colors.white,
      splashIconSize: 500,
      animationDuration: Duration(seconds: 3),
      splash:// Full height
             Image.asset(Appassets.logoo,),
        curve: Curves.easeIn,
            // Covers the full screen without white spaces
      nextScreen: Firstscreen(),
    ),


    );

  }
}
