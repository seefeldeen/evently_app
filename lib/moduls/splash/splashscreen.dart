import 'package:animate_do/animate_do.dart';
import 'package:events/core/constants/App_assets/Appassets.dart';
import 'package:events/core/manager/app_provider.dart';
import 'package:events/core/routes/route_names.dart';
import 'package:events/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();


    Future.delayed(const Duration(seconds: 2), () async {
      final provider = Provider.of<app_provider>(context, listen: false);
      final isFirstTime = await provider.Firsttimegetter();
      final currentUser = FirebaseAuth.instance.currentUser;

      if (isFirstTime) {
        navigatorKey.currentState!.pushReplacementNamed(route_names.welcome);
      } else {
        if (currentUser == null) {
          navigatorKey.currentState!
              .pushReplacementNamed(route_names.Sign_in);
        } else {
          navigatorKey.currentState!.pushReplacementNamed(route_names.layout);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            // Logo animation
            BounceInDown(
              duration: const Duration(milliseconds: 1200),
              child: Hero(
                tag: "logo",
                child: Image.asset(
                  Appassets.logoo,
                  height: 180,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // App name animation

            const Spacer(),

            // This part is hidden but used to delay screen transition
            FadeInUp(
              delay: const Duration(seconds: 2),
              child: const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}

