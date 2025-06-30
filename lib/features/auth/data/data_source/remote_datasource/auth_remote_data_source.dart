import 'package:dio/dio.dart';
import 'package:gadgetify/features/auth/domain/entity/auth_entity.dart';

// This class is responsible for making API calls for authentication.
class AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  Future<void> signup(AuthEntity user) async {
    try {
      // CORRECTED URL: Removed the "/auth" part to match your API route.
      await _dio.post(
        'http://10.0.2.2:5005/api/signup',
        data: {"email": user.email, "password": user.password},
      );
    } on DioException catch (e) {
      throw Exception('API signup failed: ${e.message}');
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      // CORRECTED URL: Removed the "/auth" part to match your API route.
      final response = await _dio.post(
        'http://10.0.2.2:5005/api/login',
        data: {"email": email, "password": password},
      );

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } on DioException {
      return false;
    }
  }
}
