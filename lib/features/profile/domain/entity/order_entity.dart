import 'package:equatable/equatable.dart';
// ✅ CORRECTED: Import ShippingInfoEntity from the checkout feature
import 'package:gadgetify/features/checkout/domain/entity/shipping_info_entity.dart';
import 'package:gadgetify/features/profile/domain/entity/order_item_entity.dart';

class OrderEntity extends Equatable {
  final String id;
  final List<OrderItemEntity> orderItems;
  final ShippingInfoEntity shippingInfo;
  final double totalPrice;
  final String orderStatus;
  final DateTime createdAt;

  const OrderEntity({
    required this.id,
    required this.orderItems,
    required this.shippingInfo,
    required this.totalPrice,
    required this.orderStatus,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    orderItems,
    shippingInfo,
    totalPrice,
    orderStatus,
    createdAt,
  ];
}
