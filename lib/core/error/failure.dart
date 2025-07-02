import 'package:equatable/equatable.dart';

// This is the corrected base Failure class.
// All other failures in the app will extend this.
class Failure extends Equatable {
  // It holds a single 'error' message.
  final String error;

  // The constructor takes a single named parameter, 'error'.
  // This is the key to fixing the TypeError.
  const Failure({required this.error});

  @override
  List<Object?> get props => [error];
}
