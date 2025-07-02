import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gadgetify/features/auth/domain/entity/auth_entity.dart';

// This class is responsible for making API calls for authentication.
class AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  // --- IMPORTANT ---
  // We dynamically determine the base URL based on the platform.
  String get _baseUrl {
    // kIsWeb is a special constant that is true when the app is running on the web.
    if (kIsWeb) {
      return 'http://localhost:5005'; // Use localhost for web builds
    }
    // For mobile (Android Emulator), use the special alias.
    // For physical devices, you would replace this with your computer's IP address.
    return 'http://10.0.2.2:5005';
  }

  Future<void> signup(AuthEntity user) async {
    try {
      await _dio.post(
        '$_baseUrl/api/signup',
        data: {"email": user.email, "password": user.password},
      );
    } on DioException catch (e) {
      // --- UPDATED ERROR HANDLING ---
      // This provides more specific feedback to help debug the root cause.
      String errorMessage =
          'API signup failed. Please check your connection and try again.';

      // Check for a specific connection error, often caused by CORS or server being down.
      if (e.type == DioExceptionType.connectionError) {
        errorMessage =
            'Connection Error: Could not connect to the server. Please ensure your backend is running and CORS is configured correctly.';
      }
      // Check if the server responded with an error code (like 404, 500).
      else if (e.response != null) {
        errorMessage =
            'Server Error: ${e.response?.statusCode} - ${e.response?.data['message'] ?? 'Unknown error'}';
      }

      if (kDebugMode) {
        // Print the full technical error in debug mode.
        print('API signup failed: $e');
      }
      throw Exception(errorMessage);
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/api/login',
        data: {"email": email, "password": password},
      );

      if (response.statusCode == 200) {
        // In a real app, you would get a token here.
        // String token = response.data['token'];
        return true;
      }
      return false;
    } on DioException {
      return false;
    }
  }
}
