import 'package:flutter/material.dart';
import 'package:gadgetify/features/auth/presentation/view/login_view.dart';
import 'package:gadgetify/features/auth/presentation/view/signup_view.dart';
import 'package:gadgetify/features/home/presentation/view/home_view.dart';
import 'package:gadgetify/features/splash/presentation/view/splash_view.dart';

class AppRouter {
  // Define route names as constants for type safety
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String signupRoute = '/signup';
  static const String homeRoute = '/home';

  // The routing logic
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case signupRoute:
        return MaterialPageRoute(builder: (_) => const SignUpView());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeView());
      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
