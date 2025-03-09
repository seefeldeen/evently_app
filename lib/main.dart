import 'package:bot_toast/bot_toast.dart';
import 'package:events/core/routes/app_routes.dart';
import 'package:events/core/theme/AppThemeManager.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:events/core/services/loadingservices.dart';

var navigatorkey = GlobalKey<NavigatorState>();


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );

  configLoading();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: AppRoutes.onGeneratedRoute,
     builder: EasyLoading.init(builder:BotToastInit() ) ,
      theme: AppThemeManager.lighttheme,
      navigatorKey: navigatorkey,
    );
  }
}