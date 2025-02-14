import 'package:ai_weather/core/helper/shared_Preference_helper.dart';
import 'package:ai_weather/features/auth/presentation/blocs/password_visibility_cubit.dart';
import 'package:ai_weather/features/auth/presentation/pages/home_page.dart';
import 'package:ai_weather/features/auth/presentation/pages/login_page.dart';
import 'package:ai_weather/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/*
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => HomePage()),
      GoRoute(
        path: '/login',
        builder: (context, state) => BlocProvider(
          create: (_) => PasswordVisibilityCubit(),
          child: LoginPage(),
        ),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => BlocProvider(
          create: (_) => PasswordVisibilityCubit(),
          child: SignupPage(),
        ),
      ),
    ],
  );
}
*/

class AppRouter {
  static Future<String> getInitialRoute() async {
    bool isLoggedIn = await SharedPrefsHelper.getLoginState();
    return isLoggedIn ? '/' : '/login'; // ✅ If logged in, go to HomePage; otherwise, LoginPage
  }

  static Future<GoRouter> createRouter() async {
    String initialRoute = await getInitialRoute();

    return GoRouter(
      initialLocation: initialRoute, // ✅ Set dynamically based on login state
      routes: [
        GoRoute(path: '/', builder: (context, state) => HomePage()),
        GoRoute(
          path: '/login',
          builder: (context, state) => BlocProvider(
            create: (_) => PasswordVisibilityCubit(),
            child: LoginPage(),
          ),
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) => BlocProvider(
            create: (_) => PasswordVisibilityCubit(),
            child: SignupPage(),
          ),
        ),
      ],
    );
  }
}