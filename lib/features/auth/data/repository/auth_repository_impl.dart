import 'package:dartz/dartz.dart';
import 'package:gadgetify/core/error/failure.dart';
import 'package:gadgetify/features/auth/data/data_source/local_datasource/auth_local_data_source.dart';
import 'package:gadgetify/features/auth/data/model/auth_hive_model.dart';
import 'package:gadgetify/features/auth/domain/entity/auth_entity.dart';
import 'package:gadgetify/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final AuthLocalDataSource _authLocalDataSource;

  AuthRepositoryImpl(this._authLocalDataSource);

  @override
  Future<Either<Failure, void>> signup({required AuthEntity user}) async {
    try {
      final authHiveModel = AuthHiveModel.fromEntity(user);
      await _authLocalDataSource.signup(authHiveModel);
      return const Right(null);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _authLocalDataSource.login(email, password);
      if (user != null) {
        return const Right(true);
      } else {
        return Left(Failure(error: "Invalid email or password"));
      }
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
