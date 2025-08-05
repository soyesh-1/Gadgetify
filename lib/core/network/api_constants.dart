import 'dart:io';

class ApiConstants {
  ApiConstants._();

  static const String androidHost = '192.168.1.80';
  static const int port = 5005;

  static String get baseUrl {
    if (Platform.isAndroid) {
      return 'http://$androidHost:$port';
    } else if (Platform.isIOS) {
      return 'http://$androidHost:$port';
    } else {
      return 'http://localhost:$port';
    }
  }

  /// Converts relative image path (e.g., `/uploads/image-123.jpg`) to full URL
  static String getImageUrl(String relativePath) {
    return '$baseUrl$relativePath';
  }
}
