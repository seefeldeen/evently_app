import 'package:events/core/ColorPallete/colorpallete.dart';
import 'package:events/core/manager/app_provider.dart';
import 'package:events/core/routes/route_names.dart';
import 'package:events/main.dart';
import 'package:events/moduls/layout/layoutprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// تأكد من استيراد الـ app_provider

class layout extends StatelessWidget {
  const layout({super.key});


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
          child: const Icon(Icons.add, color: colorpallete.parimary),
          onPressed: () {
            navigatorKey.currentState!.pushNamed(route_names.eventcreation);
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
              icon: const Icon(Icons.home_outlined),
              activeIcon: const Icon(Icons.home),
              label: context.tr.home,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.location_on_outlined),
              activeIcon: const Icon(Icons.location_on),
              label: context.tr.map,
            ),
            const BottomNavigationBarItem(
              icon: SizedBox.shrink(),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.favorite_border_outlined),
              activeIcon: const Icon(Icons.favorite),
              label: context.tr.liked,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline),
              activeIcon: const Icon(Icons.person),
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
