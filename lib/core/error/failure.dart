import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String error;
  const Failure({required this.error});

  @override
  List<Object?> get props => [error];
}
