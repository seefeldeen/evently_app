import 'package:bot_toast/bot_toast.dart';
import 'package:events/core/routes/app_routes.dart';
import 'package:events/core/theme/AppThemeManager.dart';
import 'package:events/core/utill/Firebasefunctions/firebase_Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:events/core/services/loadingservices.dart';

var navigatorkey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  configLoading();  // This is your custom loading config
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    // Firebase authentication listener for auth state changes
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print("//////// user signed out");
        // You can add any additional logic here, such as navigating to login screen.
      } else {
        print("//////// user signed in");
        // You can handle the signed-in user here
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: AppRoutes.onGeneratedRoute,
      builder: EasyLoading.init(builder: BotToastInit()),
      theme: AppThemeManager.lighttheme,
      navigatorKey: navigatorkey,
    );
  }
}
