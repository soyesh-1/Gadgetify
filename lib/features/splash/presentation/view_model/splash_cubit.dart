import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_state.dart';
// import 'package:hive/hive.dart'; // We will use this later

class SplashCubit extends Cubit<SplashState> {
  // The initial state is SplashInitial
  SplashCubit() : super(SplashInitial());

  void checkLoginStatus() {
    // Wait for 2 seconds to show the splash screen
    Timer(const Duration(seconds: 2), () async {
      
    
      emit(SplashNavigateToLogin());
    });
  }
}
