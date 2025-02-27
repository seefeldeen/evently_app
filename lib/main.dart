import 'package:events/core/routes/app_routes.dart';
import 'package:events/core/theme/AppThemeManager.dart';
import 'package:flutter/material.dart';
import 'package:events/core/routes/app_routes.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: AppRoutes.onGeneratedRoute,
      theme: AppThemeManager.lighttheme,
    );
  }
}