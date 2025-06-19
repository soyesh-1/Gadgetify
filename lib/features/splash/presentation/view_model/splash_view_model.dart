import 'dart:async';
import 'package:flutter/material.dart';

class SplashViewModel extends ChangeNotifier {
  // This method contains the navigation logic.
  // It will be called from the View.
  void checkLoginStatus(BuildContext context) {
    // Wait for 2 seconds, then navigate to the login screen.
    // We use pushReplacement to prevent the user from going back to the splash screen.
    Timer(const Duration(seconds: 2), () {
      // In a real app, you would check for a logged-in user here.
      // For now, we always go to the login screen.
      // We will replace '/login' with a proper route name later.
      Navigator.pushReplacementNamed(context, '/login');
    });
  }
}
