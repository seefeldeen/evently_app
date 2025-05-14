import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:events/core/ColorPallete/colorpallete.dart';
import 'package:events/core/constants/App_assets/Appassets.dart';
import 'package:events/core/extensions/PaddingExtention.dart';
import 'package:events/core/manager/app_provider.dart';
import 'package:events/core/routes/route_names.dart';
import 'package:events/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class welcomescreen extends StatelessWidget {
  const welcomescreen({super.key});
  static String routename = "/welcome_Screen";

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<app_provider>(context);

    return Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          const SizedBox(height: 60),
          Row(
            textDirection: TextDirection.ltr,

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Appassets.evently,
              ),
            ],
          ),
          Image.asset(
            Appassets.beingcreative,
          ).Setoptionalpadding(context, 14, 0, 12, 12),
          const SizedBox(height: 40),
          Text(context.tr.startTitle,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    decorationThickness: 2,
                    color: colorpallete.darkblue,
                  )).Sethorizontalpadding(context, .05),
          SizedBox(
            child: Text(
                context.tr.startDesc,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      decorationThickness: 2,
                  color:  Theme.of(context).textTheme.bodyMedium?.color,

            )).Setoptionalpadding(context, 6, .12, 12, 12),
          ),
          Row(
              textDirection: TextDirection.ltr,
              children: [
            Text(context.tr.lang,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      decorationThickness: 2,
                      decorationColor: colorpallete.darkblue,
                      color: colorpallete.darkblue,
                    )),
            const Spacer(),
            AnimatedToggleSwitch<String>.rolling(
              current: provider.lang,  // Get the current language from the provider
              values: const ["en", "ar"],
              onChanged: (i) {
                provider.changeLang();  // Update the language using the provider
              },

              style: ToggleStyle(
                backgroundColor: Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                borderColor: colorpallete.darkblue,
                indicatorColor: colorpallete.darkblue,
                indicatorBorderRadius: BorderRadius.circular(30),
              ), // optional style settings
              iconList: [
                 Image.asset(Appassets.english),
                Image.asset(Appassets.arabic)
              ], // many more parameters available
            )
          ]).Setoptionalpadding(context, 6, 6, .15, 12),
          Row(
              textDirection: TextDirection.ltr,
              children: [
            Text(context.tr.theme,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      decorationThickness: 2,
                      decorationColor: colorpallete.darkblue,
                      color: colorpallete.darkblue,
                    )),
            const Spacer(),
            AnimatedToggleSwitch<ThemeMode>.rolling(
              current: Provider.of<app_provider>(context).currenttheme,  // Get the theme from the provider
              values: const [
                ThemeMode.light,
                ThemeMode.dark,
              ],
              onChanged: (i) {
                Provider.of<app_provider>(context, listen: false).changeTheme();  // Update the theme using the provider
              },
              style: ToggleStyle(
                backgroundColor: Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                borderColor: colorpallete.darkblue,
                indicatorColor: colorpallete.darkblue,
                indicatorBorderRadius: BorderRadius.circular(30),
              ),
              iconList: [
                Image.asset(Appassets.lighttheme),
                Image.asset(Appassets.darktheme, color: provider.currenttheme ==
                  ThemeMode.dark ? colorpallete.parimary : null),
              ],
            )
          ]).Setoptionalpadding(context, 6, 6, .12, 12),
          ElevatedButton(
              onPressed: () {
                provider.Firsttimesetter();
                navigatorkey.currentState!.pushNamed(route_names.onboarding);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorpallete.darkblue,
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(
                context.tr.lStart,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inter"),
              )).Setoptionalpadding(context, 12, 6, 12, 12),
        ]));
  }
}
