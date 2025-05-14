import 'package:bot_toast/bot_toast.dart';
import 'package:events/core/manager/app_provider.dart';
import 'package:events/core/routes/app_routes.dart';
import 'package:events/core/theme/AppThemeManager.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:events/core/services/loadingservices.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

var navigatorkey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  configLoading(); // إعدادات التحميل

  // 👉 تحميل الثيم المحفوظ قبل بناء التطبيق
  final appProvider = app_provider();
  await appProvider.getTheme();

  runApp(
    ChangeNotifierProvider.value(
      value: appProvider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<app_provider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(
        builder: (BotToastInit()),
      ), // << مهم جدا
      title: 'Localizations Sample App',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // الإنجليزية
        Locale('ar'), // العربية
      ],
      locale: Locale(provider.lang),
      navigatorKey: navigatorkey,
      theme: AppThemeManager.lightTheme,
      themeMode: provider.currenttheme,
      darkTheme: AppThemeManager.darkTheme,
      onGenerateRoute: AppRoutes.onGeneratedRoute,
    );
  }
}

// 🔄 اختصار للوصول للترجمات بسهولة
extension Localization on BuildContext {
  AppLocalizations get tr => AppLocalizations.of(this)!;
}
