import 'package:gadgetify/core/utils/typedef.dart';
import 'package:gadgetify/features/cart/domain/entity/cart_entity.dart';
import 'package:gadgetify/features/checkout/domain/entity/shipping_info_entity.dart';

abstract class ICheckoutRepository {
  DataState<void> createOrder(
    List<CartItemEntity> cartItems,
    ShippingInfoEntity shippingInfo,
  );
}
