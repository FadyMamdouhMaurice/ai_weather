import 'package:ai_weather_cellula/core/localization/app_localizations.dart';
import 'package:ai_weather_cellula/core/theme/colors.dart';
import 'package:ai_weather_cellula/core/theme/gradient_theme_extension.dart';
import 'package:ai_weather_cellula/features/auth/domain/entities/user.dart';
import 'package:ai_weather_cellula/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:ai_weather_cellula/features/auth/presentation/blocs/auth_event.dart';
import 'package:ai_weather_cellula/features/auth/presentation/blocs/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_weather_cellula/core/components/button.dart';
import 'package:ai_weather_cellula/core/components/textfeild.dart';
import 'package:ai_weather_cellula/features/auth/presentation/blocs/password_visibility_cubit.dart';
import 'package:go_router/go_router.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gradientTheme = theme.extension<GradientThemeExtension>();

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
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
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
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (BuildContext context, AuthState state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            myTextFeild(
                              onChanged: (value) => context.read<AuthBloc>().add(NameChanged(value)),
                              keyboardType: TextInputType.text,
                              lableText: AppLocalizations.of(context)!
                                  .translate('Name'),
                            ),
                            myTextFeild(
                              onChanged: (value) => context.read<AuthBloc>().add(EmailChanged(value)),
                              keyboardType: TextInputType.emailAddress,
                              lableText: AppLocalizations.of(context)!
                                  .translate('Email'),
                            ),
                            const SizedBox(height: 16),
                            BlocBuilder<PasswordVisibilityCubit, bool>(
                              builder: (context, isPasswordObscure) {
                                return myTextFeild(
                                  onChanged: (value) => context.read<AuthBloc>().add(PasswordChanged(value)),
                                  keyboardType: TextInputType.visiblePassword,
                                  lableText:
                                  AppLocalizations.of(context)!.translate(
                                      'Password'),
                                  isObscure: isPasswordObscure,
                                  suffixIcon:
                                  isPasswordObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  onSuffixIconTap: () =>
                                      context
                                          .read<PasswordVisibilityCubit>()
                                          .toggleVisibility(),
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            BlocBuilder<ConfirmPasswordVisibilityCubit, bool>(
                              builder: (context, isConfirmPasswordObscure) {
                                return myTextFeild(
                                  onChanged: (value) => context.read<AuthBloc>().add(ConfirmPasswordChanged(value)),
                                  keyboardType: TextInputType.visiblePassword,
                                  lableText: AppLocalizations.of(context)!
                                      .translate('ConfirmPassword'),
                                  isObscure: isConfirmPasswordObscure,
                                  suffixIcon:
                                  isConfirmPasswordObscure ? Icons
                                      .visibility_off : Icons.visibility,
                                  onSuffixIconTap: () =>
                                      context
                                          .read<
                                          ConfirmPasswordVisibilityCubit>()
                                          .toggleVisibility(),
                                );
                              },
                            ),
                            myTextFeild(
                              onChanged: (value) => context.read<AuthBloc>().add(PhoneChanged(value)),
                              keyboardType: TextInputType.phone,
                              lableText: AppLocalizations.of(context)!
                                  .translate('Phone'),
                            ),
                          ],
                        );
                      },
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
                      onPressed: () {
                        final state = context.read<AuthBloc>().state;
                        if (state is RegisterFormState && state.isFormValid) {
                          final user = UserEntity(
                            userId: '',
                            name: state.name,
                            email: state.email,
                            phone: state.phone,
                          );

                          context.read<AuthBloc>().add(RegisterEvent(user, state.password));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please fill in all required fields correctly.')),
                          );
                        }
                      },
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