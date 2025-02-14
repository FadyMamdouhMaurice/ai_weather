import 'package:ai_weather/core/localization/app_localizations.dart';
import 'package:ai_weather/core/theme/colors.dart';
import 'package:ai_weather/core/theme/gradient_theme_extension.dart';
import 'package:ai_weather/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:ai_weather/features/auth/presentation/blocs/auth_state.dart';
import 'package:ai_weather/features/auth/presentation/viewmodels/register_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_weather/core/components/button.dart';
import 'package:ai_weather/core/components/textfeild.dart';
import 'package:ai_weather/features/auth/presentation/blocs/password_visibility_cubit.dart';
import 'package:go_router/go_router.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gradientTheme = theme.extension<GradientThemeExtension>();
    final viewModel = context.watch<RegisterViewModel>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.translate('SignUp'),
            style: const TextStyle(color: AppColors.textPrimaryColor)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => GoRouter.of(context).go('/'),
          ),
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (BuildContext context, AuthState state) {
          if (state is Authenticated) {
            GoRouter.of(context).go('/weather'); // Navigate to WeatherPage
          }
        },
        child: Container(
          decoration: BoxDecoration(
            gradient:
                gradientTheme?.backgroundGradient, // Get gradient from theme
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        myTextFeild(
                          controller: viewModel.nameController,
                          keyboardType: TextInputType.text,
                          lableText: AppLocalizations.of(context)!.translate('Name'),
                        ),
                        myTextFeild(
                          controller: viewModel.emailController,
                          keyboardType: TextInputType.emailAddress,
                          lableText: AppLocalizations.of(context)!.translate('Email'),
                        ),
                        const SizedBox(height: 16),
                        BlocBuilder<PasswordVisibilityCubit, bool>(
                          builder: (context, isPasswordObscure) {
                            return myTextFeild(
                              controller: viewModel.passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              lableText:
                                  AppLocalizations.of(context)!.translate('Password'),
                              isObscure: isPasswordObscure,
                              suffixIcon:
                              isPasswordObscure ? Icons.visibility_off : Icons.visibility,
                              onSuffixIconTap: () => context
                                  .read<PasswordVisibilityCubit>()
                                  .toggleVisibility(),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        BlocBuilder<ConfirmPasswordVisibilityCubit, bool>(
                          builder: (context, isConfirmPasswordObscure) {
                            return myTextFeild(
                              controller: viewModel.confirmPasswordController,
                              keyboardType: TextInputType.visiblePassword,
                              lableText: AppLocalizations.of(context)!
                                  .translate('ConfirmPassword'),
                              isObscure: isConfirmPasswordObscure,
                              suffixIcon:
                              isConfirmPasswordObscure ? Icons.visibility_off : Icons.visibility,
                              onSuffixIconTap: () => context
                                  .read<ConfirmPasswordVisibilityCubit>()
                                  .toggleVisibility(),
                            );
                          },
                        ),
                        myTextFeild(
                          controller: viewModel.phoneController,
                          keyboardType: TextInputType.phone,
                          lableText: AppLocalizations.of(context)!.translate('Phone'),
                        ),
                      ],
                    ),
                  ),
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (BuildContext context, AuthState state) {
                    if (state is AuthLoading) {
                      return const CircularProgressIndicator();
                    }
                    if (state is AuthError) {
                      return Text(state.message,
                          style: const TextStyle(color: AppColors.errorColor));
                    }
                    return myButton(
                      //onPressed: viewModel.isFormValid ? viewModel.register : null,
                      onPressed: viewModel.register,
                      text: AppLocalizations.of(context)!.translate('SignUp'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}