
import 'package:events/core/routes/route_names.dart';
import 'package:events/moduls/createevent/create_event.dart';
import 'package:events/moduls/forgetpass/forgetpass.dart';
import 'package:events/moduls/layout/layout.dart';
import 'package:events/moduls/onboardingscreens/onboareding1.dart';
import 'package:events/moduls/onboardingscreens/welcomescreen.dart';
import 'package:events/moduls/signin/Signin.dart';
import 'package:events/moduls/signup/Signup.dart';
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

        return MaterialPageRoute(builder: (context)=>  onboarding(),
            settings:  settings

        );
        case route_names.Sign_in:

        return MaterialPageRoute(builder: (context)=>  Signin(),
            settings:  settings

        );

        case route_names.Sign_up:

        return MaterialPageRoute(builder: (context)=> Signup(),
            settings:  settings

        );
        case route_names.forgetpass:

        return MaterialPageRoute(builder: (context)=> forgetpass(),
            settings:  settings

        );
      case route_names.welcome :

        return MaterialPageRoute(builder: (context)=> welcomescreen(),
            settings:  settings

        );
        case route_names.layout :

        return MaterialPageRoute(builder: (context)=> layout(),
            settings:  settings

        );
        case route_names.eventcreation :

        return MaterialPageRoute(builder: (context)=> CreateEvent(),
            settings:  settings

        );

       default  :

        return MaterialPageRoute(builder: (context)=> Splash_screen(),
            settings:  settings

        );


    }


  }


}