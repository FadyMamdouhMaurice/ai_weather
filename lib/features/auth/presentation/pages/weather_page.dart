import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => GoRouter.of(context).go('/'),
          ),
        ],
      ),
    );
  }
}
