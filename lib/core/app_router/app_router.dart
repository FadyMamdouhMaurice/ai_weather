import 'package:ai_weather_cellula/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:ai_weather_cellula/features/auth/presentation/blocs/auth_state.dart';
import 'package:ai_weather_cellula/features/auth/presentation/blocs/password_visibility_cubit.dart';
import 'package:ai_weather_cellula/features/auth/presentation/pages/home_page.dart';
import 'package:ai_weather_cellula/features/auth/presentation/pages/login_page.dart';
import 'package:ai_weather_cellula/features/auth/presentation/pages/signup_page.dart';
import 'package:ai_weather_cellula/features/weather/presentation/pages/weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static GoRouter createRouter(BuildContext context, AuthState state) {
    return GoRouter(
      routes: [
        GoRoute(path: '/', builder: (context, state) =>  HomePage()),
        GoRoute(
          path: '/login',
          builder:
              (context, state) => MultiProvider(
                providers: [
                  BlocProvider.value(value: context.read<AuthBloc>()),
                  BlocProvider(create: (_) => PasswordVisibilityCubit()),
                ],
                child: const LoginPage(),
              ),
        ),
        GoRoute(
          path: '/signup',
          builder:
              (context, state) => MultiProvider(
                providers: [
                  BlocProvider.value(value: context.read<AuthBloc>()),
                  BlocProvider(create: (_) => PasswordVisibilityCubit()),
                  BlocProvider(create: (_) => ConfirmPasswordVisibilityCubit()),
                ],
                child: const SignupPage(),
              ),
        ),
        GoRoute(
          path: '/weather',
          builder: (context, state) {
            return WeatherPage(); // WeatherBloc is already provided globally
          },
        ),
      ],
      /*redirect: (context, state) {
        final authState = context.read<AuthBloc>().state;        // If authenticated, start at /weather
        if (authState is Authenticated) {
          return '/weather';
        }
        // If not authenticated, start at home
        return '/';
      },*/
    );
  }
}
