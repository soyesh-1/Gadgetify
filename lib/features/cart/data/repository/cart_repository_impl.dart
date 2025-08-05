import 'package:dartz/dartz.dart';
import 'package:gadgetify/core/error/failure.dart';
import 'package:gadgetify/core/utils/typedef.dart';
import 'package:gadgetify/features/cart/data/data_source/local_datasource/cart_local_data_source.dart';
import 'package:gadgetify/features/cart/data/model/cart_item_hive_model.dart';
import 'package:gadgetify/features/cart/domain/entity/cart_entity.dart';
import 'package:gadgetify/features/cart/domain/repository/cart_repository.dart';

class CartRepositoryImpl implements ICartRepository {
  final CartLocalDataSource _localDataSource;

  CartRepositoryImpl(this._localDataSource);

  @override
  DataState<void> addCartItem(CartItemEntity item) async {
    try {
      final hiveItem = CartItemHiveModel.fromEntity(item);
      await _localDataSource.addCartItem(hiveItem);
      return const Right(null);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  @override
  DataState<void> removeCartItem(String productId) async {
    try {
      await _localDataSource.removeCartItem(productId);
      return const Right(null);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  @override
  DataState<List<CartItemEntity>> getAllCartItems() async {
    try {
      final hiveItems = await _localDataSource.getAllCartItems();
      final entities = hiveItems.map((item) => item.toEntity()).toList();
      return Right(entities);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
