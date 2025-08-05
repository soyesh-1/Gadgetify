import 'package:gadgetify/core/utils/typedef.dart';
import 'package:gadgetify/features/wishlist/domain/entity/wishlist_item_entity.dart';

abstract class IWishlistRepository {
  DataState<void> addToWishlist(WishlistItemEntity item);
  DataState<void> removeFromWishlist(String productId);
  DataState<List<WishlistItemEntity>> getAllWishlistItems();
}
