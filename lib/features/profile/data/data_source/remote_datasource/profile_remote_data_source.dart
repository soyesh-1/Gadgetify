import 'package:dio/dio.dart';
import 'package:gadgetify/core/error/exceptions.dart';
import 'package:gadgetify/features/auth/data/data_source/local_datasource/auth_local_data_source.dart';
import 'package:gadgetify/features/profile/data/model/order_model.dart';

abstract class ProfileRemoteDataSource {
  Future<List<OrderModel>> getMyOrders();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final Dio _dio;
  final AuthLocalDataSource _authLocalDataSource;

  ProfileRemoteDataSourceImpl(this._dio, this._authLocalDataSource);

  @override
  Future<List<OrderModel>> getMyOrders() async {
    try {
      final token = await _authLocalDataSource.getToken();

      if (token == null || token.isEmpty) {
        throw const ServerException(message: 'User not authenticated.');
      }

      final response = await _dio.get(
        '/api/orders/myorders',
        options: Options(
          headers: {'x-auth-token': token, 'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => OrderModel.fromJson(json)).toList();
      } else {
        throw ServerException(
          message: 'Failed to load orders: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['msg'] ?? e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
