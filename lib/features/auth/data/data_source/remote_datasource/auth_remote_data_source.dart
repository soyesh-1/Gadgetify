import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gadgetify/features/auth/domain/entity/auth_entity.dart';

class AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  String get _baseUrl {
    // This logic automatically selects the correct IP address based on the platform.
    if (kIsWeb) {
      // Use localhost when running the Flutter app in a web browser.
      return 'http://localhost:5005';
    }
    // Use the special alias for the Android Emulator.
    return 'http://10.0.2.2:5005';
    // Note: For a physical device, you would need to use your computer's network IP.
  }

  // --- SIGNUP METHOD ---
  Future<void> signup(AuthEntity user) async {
    // Combine the base URL with the specific API endpoint.
    final signupUrl = '$_baseUrl/api/auth/signup';

    try {
      await _dio.post(
        signupUrl,
        data: {"email": user.email, "password": user.password},
      );
    } on DioException catch (e) {
      // This provides detailed error messages to help debug.
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

  // --- LOGIN METHOD ---
  Future<bool> login(String email, String password) async {
    final loginUrl = '$_baseUrl/api/auth/login';
    try {
      final response = await _dio.post(
        loginUrl,
        data: {"email": email, "password": password},
      );

      return response.statusCode == 200;
    } on DioException {
      // In a real app, you would handle login errors more gracefully.
      return false;
    }
  }
}
