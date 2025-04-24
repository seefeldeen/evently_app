import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events/core/ColorPallete/colorpallete.dart';
import 'package:events/core/constants/App_assets/Appassets.dart';
import 'package:events/core/extensions/PaddingExtention.dart';
import 'package:events/core/extensions/SizeExtention.dart';
import 'package:events/core/manager/app_provider.dart';
import 'package:events/core/models/Eventcategory.dart';
import 'package:events/core/models/Eventdata.dart';
import 'package:events/core/routes/route_names.dart';
import 'package:events/core/utill/Firebasefunctions/firebasefunctions.dart';
import 'package:events/core/widgets/Customtextshape.dart';
import 'package:events/core/widgets/Cutomelevatedbutton.dart';
import 'package:events/core/widgets/EventTypeTab.dart';
import 'package:events/main.dart';
import 'package:events/moduls/layout/Widgets/event_card.dart';
import 'package:events/moduls/layout/Widgets/hometapbar.dart';
import 'package:events/moduls/layout/favourite/fav_tap.dart';
import 'package:events/moduls/layout/home/home_tap.dart';
import 'package:events/moduls/layout/layoutprovider.dart';
import 'package:events/moduls/layout/location/map_tap.dart';
import 'package:events/moduls/layout/profile/profile_tap.dart';
import 'package:events/moduls/layout/profile/profile_tap.dart';
import 'package:events/moduls/onboardingscreens/welcomescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:events/core/manager/app_provider.dart';  // تأكد من استيراد الـ app_provider

class layout extends StatelessWidget {
  layout({super.key});


  @override
  Widget build(BuildContext context) {

    final appprovider = Provider.of<app_provider>(context);  // احصل على الـ provider
    var theme = Theme.of(context);  // احصل على الثيم الحالي

    return ChangeNotifierProvider(
        create: (context) => LayoutProvider()..fetchAllEvents(),
        child: Consumer<LayoutProvider>(
        builder: (context, provider, child) {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: colorpallete.parimary),
          onPressed: () {
            navigatorkey.currentState!.pushNamed(route_names.eventcreation);
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: provider.selectedIndex,
          onTap: provider.changeBottomNav,
          backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,  // تحديث اللون بناءً على الثيم
          selectedItemColor: theme.bottomNavigationBarTheme.selectedItemColor,  // تحديث اللون بناءً على الثيم
          unselectedItemColor: theme.bottomNavigationBarTheme.unselectedItemColor,  // تحديث اللون بناءً على الثيم
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: context.tr.home,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined),
              activeIcon: Icon(Icons.location_on),
              label: context.tr.map,
            ),
            BottomNavigationBarItem(
              icon: SizedBox.shrink(),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined),
              activeIcon: Icon(Icons.favorite),
              label: context.tr.liked,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: context.tr.profile,
            ),
          ],
        ),
        body: provider.bottombarwidget[provider.selectedIndex],
      );
        }
    )
    );
  }
}
