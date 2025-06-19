import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  // The initial state is AuthInitial
  AuthCubit() : super(AuthInitial());

  // The login method that will be called from the view
  void login(String email, String password) {
    // 1. Emit the loading state to show a progress indicator
    emit(AuthLoading());

    // Simulate a network delay
    Future.delayed(const Duration(seconds: 1), () {
      if (email.isEmpty || password.isEmpty) {
        emit(const AuthFailure('Please fill in all fields'));
      } else if (email == 'soyesh@gmail.com' && password == 'soyesh123') {
        // 2. If credentials are correct, emit the success state
        emit(AuthSuccess());
      } else {
        // 3. If credentials are wrong, emit the failure state with a message
        emit(const AuthFailure('Invalid email or password'));
      }
    });
  }
}
