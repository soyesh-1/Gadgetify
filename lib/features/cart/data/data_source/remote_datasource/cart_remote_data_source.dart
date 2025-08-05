import 'package:dio/dio.dart';
import 'package:gadgetify/core/error/exceptions.dart';
import 'package:gadgetify/features/auth/data/data_source/local_datasource/auth_local_data_source.dart';
import 'package:gadgetify/features/cart/domain/entity/cart_entity.dart';

class CartRemoteDataSource {
  final Dio _dio;
  final AuthLocalDataSource _authLocalDataSource;

  CartRemoteDataSource(this._dio, this._authLocalDataSource);

  Future<void> createOrder(List<CartItemEntity> cartItems) async {
    try {
      final token = await _authLocalDataSource.getToken();
      if (token == null) {
        throw const ServerException(message: 'User not authenticated.');
      }

      final orderItems =
          cartItems
              .map(
                (item) => {
                  "product": item.productId,
                  "name": item.name,
                  "qty": item.quantity,
                  "price": item.price,
                  "image": item.image,
                },
              )
              .toList();

      final totalPrice = cartItems.fold(
        0.0,
        (total, item) => total + (item.price * item.quantity),
      );

      await _dio.post(
        '/api/orders',
        data: {
          "orderItems": orderItems,
          "totalPrice": totalPrice,
          // In a real app, you would pass the full shipping info from a form
          "shippingInfo": {
            "address": "Default Address",
            "city": "Default City",
            "phoneNo": "0000000000",
          },
        },
        options: Options(headers: {'x-auth-token': token}),
      );
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'API order creation failed.',
      );
    }
  }
}
