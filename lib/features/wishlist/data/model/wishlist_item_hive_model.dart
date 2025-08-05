import 'package:equatable/equatable.dart';
import 'package:gadgetify/app/constant/hive_table_constant.dart';
import 'package:gadgetify/features/wishlist/domain/entity/wishlist_item_entity.dart';
import 'package:hive/hive.dart';

part 'wishlist_item_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.wishlistItemTableId)
class WishlistItemHiveModel extends Equatable {
  @HiveField(0)
  final String productId;

  const WishlistItemHiveModel({required this.productId});

  // Convert Hive Model to Entity
  WishlistItemEntity toEntity() => WishlistItemEntity(productId: productId);

  // Convert Entity to Hive Model
  factory WishlistItemHiveModel.fromEntity(WishlistItemEntity entity) {
    return WishlistItemHiveModel(productId: entity.productId);
  }

  @override
  List<Object?> get props => [productId];
}
