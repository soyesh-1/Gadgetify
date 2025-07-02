import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? id;
  final String name; // <-- We added this field
  final String email;
  final String password;

  const AuthEntity({
    this.id,
    required this.name, // <-- and made it required
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [id, name, email, password];
}
