import 'package:events/core/ColorPallete/colorpallete.dart';
import 'package:events/core/constants/App_assets/Appassets.dart';
import 'package:events/core/extensions/PaddingExtention.dart';
import 'package:events/core/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class onboarding extends StatefulWidget {
  static const String routeName = "/on_boarding_view";


  onboarding({super.key});

  @override
  State<onboarding> createState() => _onboarding();
}

class _onboarding extends State<onboarding> {
  final List<String> welcomePhotos = [
    Appassets.hottrending,
    Appassets.manager,
    Appassets.socialmedia,
  ];

  final List<String> welcomeQuotes = [
    "Find Events That Inspire You",
    "Effortless Event Planning",
    "Connect with Friends & Share Moments",

  ];
  final List<String> welcomedescribtion = [
    "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
    "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
    "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",

  ];

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 40),
          Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Appassets.smalllogo),
                SizedBox(width: 20),
                Image.asset(Appassets.evently,),
              ],
            ),
          )
          ,Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: welcomePhotos.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.all(18.0),
                      child:  SizedBox( height: 400
                        ,child: Image.asset(
                          welcomePhotos[index],
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    Text(
                      welcomeQuotes[index],
                     style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                decorationThickness: 2,
                decorationColor: colorpallete.darkblue,
                color: colorpallete.darkblue,)
                ).Sethorizontalpadding(context, .02),


                    Text( welcomedescribtion[index] ,style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      decorationThickness: 2,
                      decorationColor: colorpallete.darkblue,
                      color: Colors.black,)
                    ).Setoptionalpadding(context, 6, .12, .12, 12),

                  ],
                );
              },
            ),
          ),
          SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Back Button
              IconButton(
                onPressed: () {
                  if (_pageController.page == 0) {
                    Navigator.pushReplacementNamed(context, '/sign_in');
                  } else {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear,
                    );
                  }
                },
                icon: Icon(
                  Icons.navigate_before,
                  color: colorpallete.parimary,
                  size: 50,
                ),
              ),
              SizedBox(width: 16),

              // Smooth Indicator
              SmoothPageIndicator(
                controller: _pageController,
                count: welcomePhotos.length,
                effect: ExpandingDotsEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: Colors.blue,
                  dotColor: Colors.grey,
                ),
              ),
              SizedBox(width: 16),

              // Next Button
              IconButton(
                onPressed: () {
                  if (_pageController.page == welcomePhotos.length - 1) {
                    Navigator.pushReplacementNamed(context, route_names.Sign_in);
                  } else {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear,
                    );
                  }
                },
                icon: Icon(
                  Icons.navigate_next,
                  color: colorpallete.darkblue,
                  size: 50,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
