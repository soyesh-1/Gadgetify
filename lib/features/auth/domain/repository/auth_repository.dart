import 'package:dartz/dartz.dart';
import 'package:gadgetify/core/error/failure.dart';
import 'package:gadgetify/features/auth/domain/entity/auth_entity.dart';

abstract class IAuthRepository {
  Future<Either<Failure, void>> signup({required AuthEntity user});
  Future<Either<Failure, bool>> login({
    required String email,
    required String password,
  });
}
