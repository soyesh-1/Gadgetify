import 'package:equatable/equatable.dart';

// The base Failure class. All other failures in the app will extend this.
// It requires an 'error' message, making our error handling consistent.
class Failure extends Equatable {
  final String error;

  const Failure({required this.error});

  @override
  List<Object?> get props => [error];
}
