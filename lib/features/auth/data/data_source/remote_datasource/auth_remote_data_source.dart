import 'package:dio/dio.dart';
import 'package:gadgetify/features/auth/domain/entity/auth_entity.dart';

// This class is responsible for making API calls for authentication.
class AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  // In a real app, this would return a user object or a token from the API.
  // For now, we simulate a successful API call.
  Future<void> signup(AuthEntity user) async {
    try {
      await _dio.post(
        'https://your-api.com/api/v1/auth/signup', // <-- REPLACE WITH YOUR API ENDPOINT
        data: {"email": user.email, "password": user.password},
      );
    } on DioException catch (e) {
      // You can handle specific Dio errors here (e.g., 400, 401, 500)
      throw Exception('API signup failed: ${e.message}');
    }
  }

  // In a real app, this would return a user object or an auth token.
  // For this example, we'll return a bool indicating success.
  Future<bool> login(String email, String password) async {
    try {
      final response = await _dio.post(
        'https://your-api.com/api/v1/auth/login', // <-- REPLACE WITH YOUR API ENDPOINT
        data: {"email": email, "password": password},
      );
      // Assuming a successful login returns a 200 status code
      if (response.statusCode == 200) {
        // You would typically get a token from the response body here.
        // For example: String token = response.data['token'];
        return true;
      }
      return false;
    } on DioException {
      // If the API returns an error (like 401 Unauthorized), Dio throws an exception.
      return false;
    }
  }
}
