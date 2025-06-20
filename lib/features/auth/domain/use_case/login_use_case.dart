import 'package:dartz/dartz.dart';
import 'package:gadgetify/core/error/failure.dart';
import 'package:gadgetify/features/auth/domain/repository/auth_repository.dart';

class LoginUseCase {
  final IAuthRepository _repository;
  LoginUseCase(this._repository);

  Future<Either<Failure, bool>> call({
    required String email,
    required String password,
  }) async {
    return await _repository.login(email: email, password: password);
  }
}
