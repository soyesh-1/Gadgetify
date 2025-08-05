import 'package:gadgetify/app/constant/hive_table_constant.dart';
import 'package:gadgetify/features/wishlist/data/model/wishlist_item_hive_model.dart';
import 'package:hive/hive.dart';

class WishlistLocalDataSource {
  Future<void> addToWishlist(WishlistItemHiveModel item) async {
    final box = await Hive.openBox<WishlistItemHiveModel>(
      HiveTableConstant.wishlistBox,
    );
    // Using productId as the key ensures no duplicates
    await box.put(item.productId, item);
  }

  Future<void> removeFromWishlist(String productId) async {
    final box = await Hive.openBox<WishlistItemHiveModel>(
      HiveTableConstant.wishlistBox,
    );
    await box.delete(productId);
  }

  Future<List<WishlistItemHiveModel>> getAllWishlistItems() async {
    final box = await Hive.openBox<WishlistItemHiveModel>(
      HiveTableConstant.wishlistBox,
    );
    return box.values.toList();
  }
}
