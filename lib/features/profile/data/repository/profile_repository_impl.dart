import 'package:dartz/dartz.dart';
import 'package:gadgetify/core/error/exceptions.dart';
import 'package:gadgetify/core/error/failure.dart';
import 'package:gadgetify/core/network/network_info.dart';
import 'package:gadgetify/core/utils/typedef.dart';
import 'package:gadgetify/features/profile/data/data_source/remote_datasource/profile_remote_data_source.dart';
import 'package:gadgetify/features/profile/domain/entity/order_entity.dart';
import 'package:gadgetify/features/profile/domain/repository/profile_repository.dart';

// UPDATED to implement IProfileRepository
class ProfileRepositoryImpl implements IProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;
  final INetworkInfo _networkInfo;

  ProfileRepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  DataState<List<OrderEntity>> getMyOrders() async {
    if (await _networkInfo.isConnected) {
      try {
        final remoteOrders = await _remoteDataSource.getMyOrders();
        return Right(remoteOrders);
      } on ServerException catch (e) {
        return Left(ServerFailure(error: e.message));
      }
    } else {
      return Left(ServerFailure(error: 'No Internet Connection'));
    }
  }
}
