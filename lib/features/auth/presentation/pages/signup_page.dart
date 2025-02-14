import 'package:ai_weather/core/localization/app_localizations.dart';
import 'package:ai_weather/core/theme/colors.dart';
import 'package:ai_weather/core/theme/gradient_theme_extension.dart';
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

    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var confirmPasswordController = TextEditingController();
    var phoneController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.translate('SignUp'),
            style: TextStyle(color: AppColors.textPrimaryColor)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => GoRouter.of(context).go('/'),
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
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  lableText: AppLocalizations.of(context)!.translate('Name')),
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
              const SizedBox(height: 16),
              BlocBuilder<PasswordVisibilityCubit, bool>(
                builder: (context, isObscure) {
                  return myTextFeild(
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    lableText: AppLocalizations.of(context)!.translate('ConfirmPassword'),
                    isObscure: isObscure,
                    suffixIcon:
                        isObscure ? Icons.visibility_off : Icons.visibility,
                    onSuffixIconTap: () => context
                        .read<PasswordVisibilityCubit>()
                        .toggleVisibility(),
                  );
                },
              ),
              myTextFeild(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  lableText: AppLocalizations.of(context)!.translate('Phone')),
              const Expanded(child: SizedBox(height: 24)),
              myButton(
                onPressed: () {
                  // Handle sign-up logic
                },
                text: AppLocalizations.of(context)!.translate('SignUp'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
