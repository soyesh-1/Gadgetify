import 'package:dartz/dartz.dart';
import 'package:gadgetify/core/error/failure.dart';
import 'package:gadgetify/features/auth/domain/entity/auth_entity.dart';
import 'package:gadgetify/features/auth/domain/repository/auth_repository.dart';

class SignUpUseCase {
  final IAuthRepository _repository;
  SignUpUseCase(this._repository);

  Future<Either<Failure, void>> call(AuthEntity user) async {
    return await _repository.signup(user: user);
  }
}
