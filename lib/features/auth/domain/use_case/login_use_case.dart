import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gadgetify/core/error/failure.dart';
import 'package:gadgetify/features/auth/domain/repository/auth_repository.dart';

// Create a dedicated class to hold the parameters for the login use case.
// This is a very clean pattern that prevents parameter mistakes.
class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class LoginUseCase {
  final IAuthRepository _repository;
  LoginUseCase(this._repository);

  // The `call` method now takes a single `LoginParams` object.
  Future<Either<Failure, bool>> call(LoginParams params) async {
    return await _repository.login(
      email: params.email,
      password: params.password,
    );
  }
}
