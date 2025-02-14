import 'package:ai_weather/core/app_router/app_router.dart';
import 'package:ai_weather/core/localization/app_localizations.dart';
import 'package:ai_weather/core/theme/colors.dart';
import 'package:ai_weather/features/auth/data/repositories/auth_repository.dart';
import 'package:ai_weather/features/auth/domain/usecases/login_use_case.dart';
import 'package:ai_weather/features/auth/domain/usecases/logout_use_case.dart';
import 'package:ai_weather/features/auth/domain/usecases/register_use_case.dart';
import 'package:ai_weather/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:ai_weather/features/auth/presentation/blocs/auth_state.dart';
import 'package:ai_weather/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final sharedPreferences = await SharedPreferences.getInstance();
  final authRepository = AuthRepository();
  final registerUseCase = RegisterUseCase(authRepository);
  final loginUseCase = LoginUseCase(authRepository);
  final logoutUseCase = LogoutUseCase(authRepository);
  runApp(
    BlocProvider(
      create: (context) => AuthBloc(
          authRepository, registerUseCase, loginUseCase, logoutUseCase),
      child: MyApp(sharedPreferences: sharedPreferences),
    ),
  );
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  const MyApp({Key? key, required this.sharedPreferences}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
      },
      child: Builder(
        builder: (context) {
          final router =
              AppRouter.createRouter(context, context.read<AuthBloc>().state);

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''), // English
              Locale('ar', ''), // Arabic
            ],
            locale: const Locale('en'),
            // Default locale

            /*localeResolutionCallback: (locale, supportedLocales) {
            return supportedLocales.contains(locale)
                ? locale
                : const Locale('en', '');
          },*/
            themeMode: ThemeMode.system,
            theme: AppColors.lightTheme,
            darkTheme: AppColors.darkTheme,
          );
        },
      ),
    );
  }
}
