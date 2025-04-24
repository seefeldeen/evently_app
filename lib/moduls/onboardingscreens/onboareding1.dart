import 'package:animate_do/animate_do.dart';
import 'package:events/core/ColorPallete/colorpallete.dart';
import 'package:events/core/constants/App_assets/Appassets.dart';
import 'package:events/core/extensions/PaddingExtention.dart';
import 'package:events/core/manager/app_provider.dart';
import 'package:events/core/routes/route_names.dart';
import 'package:events/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onboarding extends StatefulWidget {
  static const String routeName = "/on_boarding_view";

  onboarding({super.key});

  @override
  State<onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<onboarding> {
  final List<String> welcomePhotos = [
    Appassets.hottrending,
    Appassets.manager,
    Appassets.socialmedia,
  ];

  final PageController _pageController = PageController();

  // These lists should be initialized once, not inside the build method
  late List<String> welcomeQuotes;
  late List<String> welcomeDescriptions;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize these once the context is available
    welcomeQuotes = [
      context.tr.boarding1Title,
      context.tr.boarding2Title,
      context.tr.boarding3Title,
    ];

    welcomeDescriptions = [
      context.tr.boarding1Desc,
      context.tr.boarding2Desc,
      context.tr.boarding3Desc,
    ];
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 40),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Appassets.evently),
              ],
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: welcomePhotos.length,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider(
                create: (context) => app_provider(),
                builder: (context, child) {
                var provider = Provider.of<app_provider>(context);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                    textDirection: provider.lang == "ar"
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(18.0),
                        child: SizedBox(
                          height: 400,
                          child: Image.asset(
                            welcomePhotos[index],
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      FadeInRightBig(
                        child: Text(
                          welcomeQuotes[index],
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            decorationThickness: 2,
                            decorationColor: colorpallete.darkblue,
                            color: colorpallete.darkblue,
                          ),
                        ).Sethorizontalpadding(context, .02),
                      ),
                      FadeInLeftBig(
                        child: Text(
                          welcomeDescriptions[index],
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            decorationThickness: 2,
                            decorationColor: colorpallete.darkblue,
                          ),
                        ).Setoptionalpadding(context, 6, .12, .12, 12),
                      ),
                    ],
                  );
                })
                ;
              },
            ).Sethorizontalpadding(context, .05),
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
