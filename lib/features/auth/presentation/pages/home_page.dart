import 'package:ai_weather/core/components/button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/scheduler.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFFFFF), // Fully opaque white
              Color(0xFF98a3ff), // Light blue
              Color(0xFF7684ff), // Medium blue
              Color(0xFF3e52ff),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Expanded(
                child: Image.asset("assets/images/cloudy.png", width: double.infinity),
              ),
              myButton(
                onPressed: () {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    context.go('/signup'); // Navigate to Signup Page
                  });
                },
                text: "Sign Up",
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              myButton(
                onPressed: () {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    context.go('/login'); // Navigate to Login Page
                  });
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
