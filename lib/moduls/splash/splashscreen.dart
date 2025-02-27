import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:events/core/constants/App_assets/Appassets.dart';
import 'package:events/moduls/onboardingscreens/onboareding1.dart';
import 'package:flutter/material.dart';

class Splash_screen extends StatelessWidget {
  const Splash_screen({super.key});

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context);
    return Scaffold(
    //   body:  AnimatedSplashScreen(
    //   backgroundColor: Colors.white,
    //   animationDuration: Duration(seconds: 2),
    //   splash:// Full height
    //          Image.asset("assets/icons/Logo.png"),
    //         // Covers the full screen without white spaces
    //   splashTransition: SplashTransition.scaleTransition,
    //   nextScreen: OnBoarding1(),
    // ),
        body: Center(
          child: Image.asset(
            Appassets.logoo,
                 fit: BoxFit.cover, // Ensures the image covers the screen
               ),
        ),
    );
  }
}
