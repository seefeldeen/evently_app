import 'package:events/core/ColorPallete/colorpallete.dart';
import 'package:events/core/constants/App_assets/Appassets.dart';
import 'package:events/core/extensions/PaddingExtention.dart';
import 'package:events/core/routes/route_names.dart';
import 'package:events/main.dart';
import 'package:flutter/material.dart';

class welcomescreen extends StatelessWidget {
  const welcomescreen({super.key});
static String routename = "/welcome_Screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          const SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Appassets.smalllogo),
              const SizedBox(width: 20),
              Image.asset(
                Appassets.evently,
              ),
            ],
          ),
          Image.asset(
            Appassets.beingcreative,
          ).Setoptionalpadding(context, 14, 0, 12, 12),
              SizedBox(height: 40),

              Text("Personalize Your Experience",style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                decorationThickness: 2,
                decorationColor: colorpallete.darkblue,
                color: colorpallete.darkblue,)
              ).Sethorizontalpadding(context, .02),

              Text("Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style. ",style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                decorationThickness: 2,
                decorationColor: colorpallete.darkblue,
                color: Colors.black,)
              ).Setoptionalpadding(context, 6, .12, .12, 12),

              Row(children: [
                Text("Language",style: Theme.of(context).textTheme
                    .titleMedium
                    ?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                decorationThickness: 2,
                  decorationColor: colorpallete.darkblue,
                  color: colorpallete.darkblue,)),
              ]).Setoptionalpadding(context, 6, 6, .12, 12),

               Row(children: [
                Text("Theme",style: Theme.of(context).textTheme
                    .titleMedium
                    ?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                decorationThickness: 2,
                  decorationColor: colorpallete.darkblue,
                  color: colorpallete.darkblue,)),
              ]).Setoptionalpadding(context, 6, 6, .12, 12),

              ElevatedButton(
                  onPressed: () {
                    navigatorkey.currentState!.pushNamed(route_names.onboarding);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorpallete.darkblue,
                    padding: EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text(
                    "Let's Start",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Inter"),
                  )).Setoptionalpadding(context, 12, 6, 12, 12),


            ]
        )
    );
  }
}
