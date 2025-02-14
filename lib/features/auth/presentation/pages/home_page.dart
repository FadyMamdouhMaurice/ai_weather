import 'package:ai_weather/core/components/button.dart';
import 'package:ai_weather/core/theme/colors.dart';
import 'package:ai_weather/core/theme/gradient_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gradientTheme = theme.extension<GradientThemeExtension>();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient:
              gradientTheme?.backgroundGradient, // Get gradient from theme
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Expanded(
                child: Image.asset("assets/images/cloudy.png",
                    width: double.infinity),
              ),
              myButton(
                onPressed: () {
                  GoRouter.of(context).go('/signup'); // Explicitly use GoRouter
                },
                text: "Sign Up",
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              myButton(
                onPressed: () {
                  GoRouter.of(context).go('/login'); // Explicitly use GoRouter
                },
                text: "Sign in",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
