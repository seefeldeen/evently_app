
import 'package:events/core/routes/route_names.dart';
import 'package:events/moduls/onboardingscreens/onboareding1.dart';
import 'package:events/moduls/signin/Sign_in.dart';
import 'package:events/moduls/signup/Sign-up.dart';
import 'package:events/moduls/splash/splashscreen.dart';
import 'package:flutter/material.dart';

abstract class AppRoutes{


  static Route onGeneratedRoute(RouteSettings settings) {

    switch (settings.name){
      case route_names.initial:

       return MaterialPageRoute(builder: (context)=> const Splash_screen(),
         settings:  settings

    );

      case route_names.onboarding:

        return MaterialPageRoute(builder: (context)=>  OnBoarding1(),
            settings:  settings

        );
        case route_names.Sign_in:

        return MaterialPageRoute(builder: (context)=> Sign_in(),
            settings:  settings

        );
        case route_names.Sign_up:

        return MaterialPageRoute(builder: (context)=> Sign_up(),
            settings:  settings

        );

       default  :

        return MaterialPageRoute(builder: (context)=> Splash_screen(),
            settings:  settings

        );


    }


  }


}