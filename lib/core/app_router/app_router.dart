import 'package:ai_weather/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:ai_weather/features/auth/presentation/blocs/auth_state.dart';
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
  static GoRouter createRouter(BuildContext context, AuthState state) {
    return GoRouter(
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomePage()),
        GoRoute(
          path: '/login',
          builder: (context, state) => BlocProvider(
            create: (_) => PasswordVisibilityCubit(),
            child: const LoginPage(),
          ),
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) => BlocProvider(
            create: (_) => PasswordVisibilityCubit(),
            child: const SignupPage(),
          ),
        ),
      ],
      redirect: (context, state) {
        final authState = context.read<AuthBloc>().state;
        if (authState is Authenticated) {
          return '/'; // Redirect to HomePage when authenticated
        } else if (authState is AuthInitial) {
          return '/login'; // Redirect to LoginPage after logout
        }
        return null; // No change
      },
    );
  }
}