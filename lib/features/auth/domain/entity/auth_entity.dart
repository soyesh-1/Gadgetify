import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? id;
  final String email;
  final String password;

  const AuthEntity({
    this.id,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [id, email, password];
}
