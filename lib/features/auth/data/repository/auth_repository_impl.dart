import 'package:dartz/dartz.dart';
import 'package:gadgetify/core/error/exceptions.dart';
import 'package:gadgetify/core/error/failure.dart';
import 'package:gadgetify/core/network/network_info.dart';
import 'package:gadgetify/features/auth/data/data_source/local_datasource/auth_local_data_source.dart';
import 'package:gadgetify/features/auth/data/data_source/remote_datasource/auth_remote_data_source.dart';
import 'package:gadgetify/features/auth/data/model/auth_hive_model.dart';
import 'package:gadgetify/features/auth/domain/entity/auth_entity.dart';
import 'package:gadgetify/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final AuthLocalDataSource _localDataSource;
  final AuthRemoteDataSource _remoteDataSource;
  final INetworkInfo _networkInfo;

  AuthRepositoryImpl(
    this._localDataSource,
    this._remoteDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, void>> signup({required AuthEntity user}) async {
    if (!await _networkInfo.isConnected) {
      return Left(Failure(error: 'No internet connection.'));
    }
    try {
      // Call the remote data source to sign up the user
      await _remoteDataSource.signup(user);

      // Also save the new user to the local Hive database
      final authHiveModel = AuthHiveModel.fromEntity(user);
      await _localDataSource.signup(authHiveModel);

      // ✅ CORRECTED: Added the missing return statement for the success case
      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure(error: e.message));
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> login({
    required String email,
    required String password,
  }) async {
    if (!await _networkInfo.isConnected) {
      return Left(Failure(error: 'No internet connection.'));
    }

    try {
      final remoteResult = await _remoteDataSource.login(email, password);

      await _localDataSource.saveToken(remoteResult.token);

      final userToSave = AuthHiveModel.fromEntity(remoteResult.user);
      final finalUserToSave = AuthHiveModel(
        userId: userToSave.userId,
        name: userToSave.name,
        email: userToSave.email,
        password: password,
      );
      await _localDataSource.signup(finalUserToSave);

      return const Right(true);
    } on ServerException catch (e) {
      return Left(Failure(error: e.message));
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
