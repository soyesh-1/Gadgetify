// lib/features/auth/data/datasource/auth_remote_data_source.dart
import 'package:dio/dio.dart';
import 'package:gadgetify/core/error/exceptions.dart';
import 'package:gadgetify/core/network/api_constants.dart';
import 'package:gadgetify/features/auth/data/model/login_response_model.dart';
import 'package:gadgetify/features/auth/domain/entity/auth_entity.dart';

class AuthRemoteDataSource {
  final Dio _dio;
  AuthRemoteDataSource(this._dio);

  String get _baseUrl => ApiConstants.baseUrl;

  Future<void> signup(AuthEntity user) async {
    final signupUrl = '$_baseUrl/api/auth/register';
    try {
      final response = await _dio.post(
        signupUrl,
        data: {
          "name": user.name,
          "email": user.email,
          "password": user.password,
        },
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerException(message: response.data['msg'] ?? 'Signup failed');
      }
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['msg'] ?? 'API signup failed.',
      );
    }
  }

  Future<LoginResponseModel> login(String email, String password) async {
    final loginUrl = '$_baseUrl/api/auth/login';
    try {
      final response = await _dio.post(
        loginUrl,
        data: {"email": email, "password": password},
      );

      if (response.statusCode == 200 && response.data['token'] != null) {
        final userData = response.data['user'] as Map<String, dynamic>?;

        if (userData == null) {
          throw const ServerException(
            message: 'User data not found in login response.',
          );
        }

        final userEntity = AuthEntity(
          id: userData['_id'],
          name: userData['name'],
          email: userData['email'],
          password: '',
        );

        return LoginResponseModel(
          token: response.data['token'],
          user: userEntity,
        );
      } else {
        throw const ServerException(
          message: 'Login failed: Invalid response from server.',
        );
      }
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['msg'] ?? 'Login failed.',
      );
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
