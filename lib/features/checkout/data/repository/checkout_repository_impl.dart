import 'package:dartz/dartz.dart';
import 'package:gadgetify/core/error/exceptions.dart';
import 'package:gadgetify/core/error/failure.dart';
import 'package:gadgetify/core/utils/typedef.dart';
import 'package:gadgetify/features/cart/domain/entity/cart_entity.dart';
import 'package:gadgetify/features/checkout/data/data_source/remote_datasource/checkout_remote_data_source.dart';
import 'package:gadgetify/features/checkout/domain/entity/shipping_info_entity.dart';
import 'package:gadgetify/features/checkout/domain/repository/checkout_repository.dart';

class CheckoutRepositoryImpl implements ICheckoutRepository {
  final CheckoutRemoteDataSource _remoteDataSource;

  CheckoutRepositoryImpl(this._remoteDataSource);

  @override
  DataState<void> createOrder(
    List<CartItemEntity> cartItems,
    ShippingInfoEntity shippingInfo,
  ) async {
    try {
      await _remoteDataSource.createOrder(cartItems, shippingInfo);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure(error: e.message));
    }
  }
}
