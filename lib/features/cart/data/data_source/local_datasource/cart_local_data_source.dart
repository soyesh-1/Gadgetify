import 'package:gadgetify/app/constant/hive_table_constant.dart';
import 'package:gadgetify/features/cart/data/model/cart_item_hive_model.dart';
import 'package:hive/hive.dart';

class CartLocalDataSource {
  Future<void> addCartItem(CartItemHiveModel item) async {
    final box = await Hive.openBox<CartItemHiveModel>(
      HiveTableConstant.cartBox,
    );
    await box.put(item.productId, item);
  }

  Future<void> removeCartItem(String productId) async {
    final box = await Hive.openBox<CartItemHiveModel>(
      HiveTableConstant.cartBox,
    );
    await box.delete(productId);
  }

  Future<List<CartItemHiveModel>> getAllCartItems() async {
    final box = await Hive.openBox<CartItemHiveModel>(
      HiveTableConstant.cartBox,
    );
    return box.values.toList();
  }
}
