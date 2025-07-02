import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gadgetify/features/auth/domain/entity/auth_entity.dart';

class AuthRemoteDataSource {
  final Dio _dio;
  AuthRemoteDataSource(this._dio);

  String get _baseUrl {
    if (kIsWeb) {
      return 'http://localhost:5005';
    }
    return 'http://10.0.2.2:5005';
  }

  Future<void> signup(AuthEntity user) async {
    final signupUrl = '$_baseUrl/api/auth/signup';
    try {
      await _dio.post(
        signupUrl,
        data: {"email": user.email, "password": user.password},
      );
    } on DioException catch (e) {
      String errorMessage =
          'API signup failed. Please check your connection and try again.';
      if (e.type == DioExceptionType.connectionError) {
        errorMessage =
            'Connection Error: Could not connect to the server at $signupUrl. Please ensure the server is running, CORS is enabled, and your device has network access.';
      } else if (e.response != null) {
        errorMessage =
            'Server Error: ${e.response?.statusCode} - ${e.response?.data['message'] ?? 'An unknown error occurred.'}';
      }
      if (kDebugMode) {
        print(errorMessage);
      }
      throw Exception(errorMessage);
    }
  }

  Future<bool> login(String email, String password) async {
    final loginUrl = '$_baseUrl/api/auth/login';
    try {
      final response = await _dio.post(
        loginUrl,
        data: {"email": email, "password": password},
      );
      return response.statusCode == 200;
    } on DioException {
      return false;
    }
  }
}
