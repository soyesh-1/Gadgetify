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
    try {
      await _dio.post(
        '$_baseUrl/api/auth/signup',
        data: {"email": user.email, "password": user.password},
      );
    } on DioException catch (e) {
      throw Exception('API signup failed: ${e.message}');
    }
  }

  // UPDATED: This now returns a String (the token) on success.
  Future<String> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/api/auth/login',
        data: {"email": email, "password": password},
      );

      if (response.statusCode == 200 && response.data['token'] != null) {
        // In a real app, you get the token from the response.
        return response.data['token'];
      } else {
        throw Exception('Login failed: Invalid response from server.');
      }
    } on DioException {
      throw Exception('Login failed: Could not connect to the server.');
    }
  }
}
