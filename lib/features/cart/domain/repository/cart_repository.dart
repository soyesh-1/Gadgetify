import 'package:gadgetify/core/utils/typedef.dart';
import 'package:gadgetify/features/cart/domain/entity/cart_entity.dart';

abstract class ICartRepository {
  DataState<void> addCartItem(CartItemEntity item);
  DataState<void> removeCartItem(String productId);
  DataState<List<CartItemEntity>> getAllCartItems();
}
