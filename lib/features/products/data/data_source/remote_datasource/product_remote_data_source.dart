import 'package:dio/dio.dart';
import 'package:gadgetify/core/error/exceptions.dart';
import 'package:gadgetify/features/products/data/model/product_model.dart';

class ProductRemoteDataSource {
  final Dio _dio;
  ProductRemoteDataSource(this._dio);

  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await _dio.get('/api/products');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data
            .map((productJson) => ProductModel.fromJson(productJson))
            .toList();
      } else {
        throw ServerException(message: 'Failed to load products from API.');
      }
    } on DioException catch (e) {
      throw ServerException(
        message:
            e.response?.data['message'] ?? 'Failed to connect to the server.',
      );
    }
  }

  Future<ProductModel> getProductById(String id) async {
    try {
      final response = await _dio.get('/api/products/$id');
      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data);
      } else {
        throw ServerException(message: 'Failed to load product with ID $id.');
      }
    } on DioException catch (e) {
      throw ServerException(
        message:
            e.response?.data['message'] ?? 'Failed to connect to the server.',
      );
    }
  }

  Future<List<ProductModel>> getProductsByCategory(String categoryName) async {
    try {
      final response = await _dio.get('/api/products/category/$categoryName');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw ServerException(
          message: 'Failed to load products for category $categoryName',
        );
      }
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to load products',
      );
    }
  }

  // --- CORRECTED: Method for searching products - changed 'q' to 'keyword' ---
  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      // Backend route is '/api/products/search', now sending 'keyword' as query parameter
      final response = await _dio.get(
        '/api/products/search',
        queryParameters: {'keyword': query},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data
            .map((productJson) => ProductModel.fromJson(productJson))
            .toList();
      } else {
        throw ServerException(
          message: 'Failed to search products: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      throw ServerException(
        message:
            e.response?.data['message'] ??
            'Failed to connect to the server for search.',
      );
    }
  }
}
