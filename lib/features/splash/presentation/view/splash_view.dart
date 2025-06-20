import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gadgetify/app/router/app_router.dart';
import '../view_model/splash_cubit.dart';
import '../view_model/splash_state.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    // We call the logic immediately when the view is built.
    context.read<SplashCubit>().checkLoginStatus();

    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        // Listens for state changes and navigates accordingly.
        if (state is SplashNavigateToLogin) {
          Navigator.pushReplacementNamed(context, AppRouter.loginRoute);
        } else if (state is SplashNavigateToHome) {
          Navigator.pushReplacementNamed(context, AppRouter.homeRoute);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF7E57C2),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.shopping_cart_checkout,
                color: Colors.white,
                size: 150,
              ),
              const SizedBox(height: 20),
              const Text(
                "Gadgetify",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
