import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void checkLoginStatus() {
    Timer(const Duration(seconds: 2), () {
      // Future logic: Check Hive for a user session token.
      // If token exists, emit(SplashNavigateToHome());
      // For now, we always navigate to login.
      emit(SplashNavigateToLogin());
    });
  }
}
