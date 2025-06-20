import 'package:flutter/material.dart';
import 'package:gadgetify/app/router/app_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gadgetify Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // On logout, navigate back to the login screen
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRouter.loginRoute,
                (route) =>
                    false, // This removes all previous routes from the stack
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Welcome to the Home Screen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
