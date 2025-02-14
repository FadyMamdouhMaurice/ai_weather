import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_weather/core/components/button.dart';
import 'package:ai_weather/core/components/textfeild.dart';
import 'package:ai_weather/features/auth/presentation/blocs/password_visibility_cubit.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var confirmPasswordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFFFFF), // Fully opaque white
              Color(0xFFD9F7FF), // Light blue
              Color(0xFF89C0F5), // Medium blue
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              myTextFeild(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                lableText: 'Email',
              ),
              const SizedBox(height: 16),
              BlocBuilder<PasswordVisibilityCubit, bool>(
                builder: (context, isObscure) {
                  return myTextFeild(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    lableText: 'Password',
                    isObscure: isObscure,
                    suffixIcon: isObscure ? Icons.visibility_off : Icons.visibility,
                    onSuffixIconTap: () => context.read<PasswordVisibilityCubit>().toggleVisibility(),
                  );
                },
              ),
              const SizedBox(height: 16),
              BlocBuilder<PasswordVisibilityCubit, bool>(
                builder: (context, isObscure) {
                  return myTextFeild(
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    lableText: 'Confirm Password',
                    isObscure: isObscure,
                    suffixIcon: isObscure ? Icons.visibility_off : Icons.visibility,
                    onSuffixIconTap: () => context.read<PasswordVisibilityCubit>().toggleVisibility(),
                  );
                },
              ),
              const SizedBox(height: 24),
              myButton(
                onPressed: () {
                  // Handle sign-up logic
                },
                text: 'Sign Up',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
