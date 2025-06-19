import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/splash_view_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    // After the widget is built, we access the ViewModel and call the logic.
    // `listen: false` is important because we don't need to rebuild this widget
    // when the ViewModel changes. We just need to call a method.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SplashViewModel>(
        context,
        listen: false,
      ).checkLoginStatus(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This is the UI part of your original code.
    return Scaffold(
      backgroundColor: const Color(0xFF7E57C2), // Or your primary app color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // IMPORTANT: Make sure you have this image in your assets folder.
            Image.asset("assets/images/gadgetify_logo.png", height: 250),
            const SizedBox(height: 30),
            const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}
