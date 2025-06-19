import 'package:equatable/equatable.dart';

// The base class for all splash states. Using Equatable for easy comparison.
abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

// The initial state of the splash screen
class SplashInitial extends SplashState {}

// The state indicating the app should navigate to the Login screen
class SplashNavigateToLogin extends SplashState {}

// The state indicating the app should navigate to the Home screen
class SplashNavigateToHome extends SplashState {}
