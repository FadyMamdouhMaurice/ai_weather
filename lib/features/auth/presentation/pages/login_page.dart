import 'package:ai_weather/core/helper/shared_Preference_helper.dart';
import 'package:ai_weather/core/theme/gradient_theme_extension.dart';
import 'package:ai_weather/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:ai_weather/features/auth/presentation/blocs/auth_event.dart';
import 'package:ai_weather/features/auth/presentation/blocs/auth_state.dart';
import 'package:ai_weather/features/auth/presentation/blocs/password_visibility_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_weather/core/components/button.dart';
import 'package:ai_weather/core/components/textfeild.dart';
import 'package:ai_weather/core/localization/app_localizations.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gradientTheme = theme.extension<GradientThemeExtension>();

    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void logout(BuildContext context) async {
      await SharedPrefsHelper.logout();
      context.go('/');
    }

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
        } else if (state is Authenticated) {
          context.go('/weather'); // Navigate to home after login
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)?.translate('title') ??
              'Default Title'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => logout(context),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient:
            gradientTheme?.backgroundGradient, // Get gradient from theme
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                myTextFeild(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  lableText: AppLocalizations.of(context)!.translate('Email'),
                ),
                const SizedBox(height: 16),
                BlocBuilder<PasswordVisibilityCubit, bool>(
                  builder: (context, isObscure) {
                    return myTextFeild(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      lableText: AppLocalizations.of(context)!.translate('Password'),
                      isObscure: isObscure,
                      suffixIcon:
                          isObscure ? Icons.visibility_off : Icons.visibility,
                      onSuffixIconTap: () => context
                          .read<PasswordVisibilityCubit>()
                          .toggleVisibility(),
                    );
                  },
                ),
                const SizedBox(height: 24),
                myButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          LoginEvent(
                              emailController.text, passwordController.text),
                        );
                  },
                  text: AppLocalizations.of(context)!.translate('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
