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
      Provider.of<SplashViewModel>(context, listen: false).checkLoginStatus(context);
    });
  }

