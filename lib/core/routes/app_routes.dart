
import 'package:events/core/models/Eventdata.dart';
import 'package:events/core/routes/route_names.dart';
import 'package:events/moduls/createevent/create_event.dart';
import 'package:events/moduls/createevent/pick_location.dart';
import 'package:events/moduls/forgetpass/forgetpass.dart';
import 'package:events/moduls/layout/home/event_details.dart';
import 'package:events/moduls/layout/layout.dart';
import 'package:events/moduls/onboardingscreens/onboareding1.dart';
import 'package:events/moduls/onboardingscreens/welcomescreen.dart';
import 'package:events/moduls/signin/Signin.dart';
import 'package:events/moduls/signup/Signup.dart';
import 'package:events/moduls/splash/splashscreen.dart';
import 'package:flutter/material.dart';

import '../../moduls/layout/home/home_tap.dart';

abstract class AppRoutes{


  static Route onGeneratedRoute(RouteSettings settings) {

    switch (settings.name){
      case route_names.initial:

       return MaterialPageRoute(builder: (context)=> const SplashScreen(),
         settings:  settings

    );

      case route_names.onboarding:

        return MaterialPageRoute(builder: (context)=>  const onboarding(),
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

        return MaterialPageRoute(builder: (context)=> const welcomescreen(),
            settings:  settings

        );
        case route_names.home :

        return MaterialPageRoute(builder: (context)=>  HomeTap(),
            settings:  settings

        );
        case route_names.layout :

        return MaterialPageRoute(builder: (context)=> const layout(),
            settings:  settings

        );
        case route_names.eventcreation :
         final event = settings.arguments as EventModel?;
        return MaterialPageRoute(builder: (context)=> CreateEvent(
            event: event,
        ),
            settings:  settings

        );

        case route_names.picklocation :
        return MaterialPageRoute(builder: (context)=> const pick_location(),
            settings:  settings

        );

    case route_names.eventdetails:
    final event = settings.arguments as EventModel;
    return MaterialPageRoute(
    builder: (context) => event_details(event: event),
    settings: settings,
    );

    // case route_names.eventedit:
    // final event = settings.arguments as EventModel;
    // return MaterialPageRoute(
    // builder: (context) => edit_event(),
    // );


       default  :

        return MaterialPageRoute(builder: (context)=> const SplashScreen(),
            settings:  settings

        );


    }


  }


}