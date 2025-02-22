import 'package:ai_weather_cellula/core/app_router/app_router.dart';
import 'package:ai_weather_cellula/core/localization/app_localizations.dart';
import 'package:ai_weather_cellula/core/theme/colors.dart';
import 'package:ai_weather_cellula/features/auth/data/repositories/auth_repository.dart';
import 'package:ai_weather_cellula/features/auth/domain/usecases/login_use_case.dart';
import 'package:ai_weather_cellula/features/auth/domain/usecases/logout_use_case.dart';
import 'package:ai_weather_cellula/features/auth/domain/usecases/register_use_case.dart';
import 'package:ai_weather_cellula/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:ai_weather_cellula/features/auth/presentation/blocs/auth_state.dart';
import 'package:ai_weather_cellula/features/weather/data/repositories/weather_repository.dart';
import 'package:ai_weather_cellula/features/weather/presentation/blocs/weather_cubit.dart';
import 'package:ai_weather_cellula/firebase_options.dart';
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
  //Pull request
  final sharedPreferences = await SharedPreferences.getInstance();
  final authRepository = AuthRepository();
  final registerUseCase = RegisterUseCase(authRepository);
  final loginUseCase = LoginUseCase(authRepository);
  final logoutUseCase = LogoutUseCase(authRepository);
  final weatherRepository = WeatherRepository();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(authRepository, registerUseCase, loginUseCase, logoutUseCase)),
        BlocProvider(create: (context) => WeatherCubit(weatherRepository)),  // Provide WeatherBloc globally
      ],
      child: MyApp(sharedPreferences: sharedPreferences),
    ),
  );
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  const MyApp({super.key, required this.sharedPreferences});

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
            ///updade
            locale: const Locale('en'),
            // Default locale

            /*localeResolutionCallback: (locale, supportedLocales) {
            return supportedLocales.contains(locale)
                ? locale
                : const Locale('en', '');
          },*/
            themeMode: ThemeMode.light,
            //themeMode: ThemeMode.system,
            theme: AppColors.lightTheme,
            darkTheme: AppColors.darkTheme,
          );
        },
      ),
    );
  }
}
