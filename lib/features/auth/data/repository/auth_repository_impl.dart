import 'package:dartz/dartz.dart';
import 'package:gadgetify/core/error/failure.dart';
import 'package:gadgetify/core/network/network_info.dart'; // Import NetworkInfo
import 'package:gadgetify/features/auth/data/data_source/local_datasource/auth_local_data_source.dart';
import 'package:gadgetify/features/auth/data/data_source/remote_datasource/auth_remote_data_source.dart'; // Import Remote Data Source
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
    // Always sign up via the API.
    if (await _networkInfo.isConnected) {
      try {
        // Call the API to register the user remotely.
        await _remoteDataSource.signup(user);
        // If the API call is successful, also save the user to the local Hive database.
        final authHiveModel = AuthHiveModel.fromEntity(user);
        await _localDataSource.signup(authHiveModel);
        return const Right(null);
      } catch (e) {
        return Left(Failure(error: e.toString()));
      }
    } else {
      return Left(Failure(error: 'No internet connection.'));
    }
  }

  @override
  Future<Either<Failure, bool>> login({
    required String email,
    required String password,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        // Try to log in using the API.
        final isSuccess = await _remoteDataSource.login(email, password);
        if (isSuccess) {
          // If remote login is successful, you could cache user data/token here.
          // For now, we just return success.
          return const Right(true);
        } else {
          return Left(Failure(error: 'Invalid credentials from API.'));
        }
      } catch (e) {
        return Left(Failure(error: e.toString()));
      }
    } else {
      // If OFFLINE, try to log in using the local Hive database.
      try {
        final user = await _localDataSource.login(email, password);
        if (user != null) {
          // Offline login successful
          return const Right(true);
        } else {
          return Left(Failure(error: 'Invalid credentials or no internet.'));
        }
      } catch (e) {
        return Left(Failure(error: e.toString()));
      }
    }
  }
}
