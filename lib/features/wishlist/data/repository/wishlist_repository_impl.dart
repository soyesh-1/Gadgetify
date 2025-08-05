import 'package:dartz/dartz.dart';
import 'package:gadgetify/core/error/failure.dart';
import 'package:gadgetify/core/utils/typedef.dart';
import 'package:gadgetify/features/wishlist/data/data_source/local_datasource/wishlist_local_data_source.dart';
import 'package:gadgetify/features/wishlist/data/model/wishlist_item_hive_model.dart';
import 'package:gadgetify/features/wishlist/domain/entity/wishlist_item_entity.dart';
import 'package:gadgetify/features/wishlist/domain/repository/wishlist_repository.dart';

class WishlistRepositoryImpl implements IWishlistRepository {
  final WishlistLocalDataSource _localDataSource;

  WishlistRepositoryImpl(this._localDataSource);

  @override
  DataState<void> addToWishlist(WishlistItemEntity item) async {
    try {
      final hiveItem = WishlistItemHiveModel.fromEntity(item);
      await _localDataSource.addToWishlist(hiveItem);
      return const Right(null);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  @override
  DataState<void> removeFromWishlist(String productId) async {
    try {
      await _localDataSource.removeFromWishlist(productId);
      return const Right(null);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  @override
  DataState<List<WishlistItemEntity>> getAllWishlistItems() async {
    try {
      final hiveItems = await _localDataSource.getAllWishlistItems();
      final entities = hiveItems.map((item) => item.toEntity()).toList();
      return Right(entities);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
