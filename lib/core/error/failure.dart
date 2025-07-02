import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String error;

  // The constructor MUST accept a named parameter 'error' of type String.
  const Failure({required this.error});

  @override
  List<Object?> get props => [error];
}
