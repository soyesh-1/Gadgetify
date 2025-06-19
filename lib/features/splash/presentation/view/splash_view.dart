import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_model/splash_cubit.dart';
import '../view_model/splash_state.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..checkLoginStatus(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigateToLogin) {
        
          } else if (state is SplashNavigateToHome) {
            // Navigator.pushReplacementNamed(context, AppRouter.homeRoute);
            print("Navigate to Home Screen"); // Placeholder action
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFF7E57C2),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/gadgetify_logo.png", height: 250),
                const SizedBox(height: 30),
                const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
