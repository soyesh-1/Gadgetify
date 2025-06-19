import 'package:equatable/equatable.dart';

// The base class for all authentication states.
// We use Equatable to easily compare state objects.
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

// The initial state of the login screen
class AuthInitial extends AuthState {}

// The state when the login process is in progress
class AuthLoading extends AuthState {}

// The state when the user has successfully logged in
class AuthSuccess extends AuthState {}

// The state when the login process fails
// It holds an error message to show to the user.
class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}
