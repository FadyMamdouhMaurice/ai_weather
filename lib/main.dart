import 'package:ai_weather/core/app_router/app_router.dart';
import 'package:ai_weather/core/localization/app_localizations.dart';
import 'package:ai_weather/core/theme/colors.dart';
import 'package:ai_weather/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/src/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final sharedPreferences = await SharedPreferences.getInstance();
  final router = await AppRouter.createRouter();

  runApp(MyApp(
    sharedPreferences: sharedPreferences,
    router: router,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  final GoRouter router;

  const MyApp({Key? key, required this.sharedPreferences, required this.router, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''), // English
        const Locale('ar', ''), // Spanish
        // Add other supported locales here
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        if (supportedLocales.contains(locale)) {
          return locale;
        }
        return const Locale('en', '');
      },
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
      ),
    );
  }
}
