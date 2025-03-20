import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:events/core/constants/App_assets/Appassets.dart';
import 'package:events/core/routes/route_names.dart';
import 'package:events/moduls/onboardingscreens/welcomescreen.dart';
import 'package:flutter/material.dart';

class Splash_screen extends StatefulWidget {
  const Splash_screen({super.key});

  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        backgroundColor: Colors.white,
        splashIconSize: 500, // Adjust the splash icon size if needed
        animationDuration: Duration(seconds: 3), // Adjust the duration to match the time you want for the splash screen
        splash: Image.asset(Appassets.logoo), // Splash image
        curve: Curves.fastOutSlowIn, // Animation curve
        nextScreen: welcomescreen(), // The next screen after splash
      ),
    );
  }
}
