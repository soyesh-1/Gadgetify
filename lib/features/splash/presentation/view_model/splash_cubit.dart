import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gadgetify/app/service_locator/service_locator.dart';
import 'package:gadgetify/features/auth/data/data_source/local_datasource/auth_local_data_source.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(AuthLocalDataSource authLocalDataSource) : super(SplashInitial());

  void checkLoginStatus() {
    Timer(const Duration(seconds: 2), () async {
      // Use the service locator to get the AuthLocalDataSource instance.
      final authLocalDataSource = sl<AuthLocalDataSource>();
      final token = await authLocalDataSource.getToken();

      if (token != null && token.isNotEmpty) {
        // If a token exists, the user is already logged in.
        emit(SplashNavigateToHome());
      } else {
        // If no token, go to the login screen.
        emit(SplashNavigateToLogin());
      }
    });
  }
}
