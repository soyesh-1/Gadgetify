import 'package:gadgetify/features/profile/data/model/order_item_model.dart';
import 'package:gadgetify/features/profile/data/model/shipping_info_model.dart';
import 'package:gadgetify/features/profile/domain/entity/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.orderItems,
    required super.shippingInfo,
    required super.totalPrice,
    required super.orderStatus,
    required super.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['_id'],
      totalPrice: (json['totalPrice'] as num).toDouble(),
      orderStatus: json['orderStatus'],
      createdAt: DateTime.parse(json['createdAt']),
      shippingInfo: ShippingInfoModel.fromJson(json['shippingInfo']),
      orderItems:
          (json['orderItems'] as List)
              .map((item) => OrderItemModel.fromJson(item))
              .toList(),
    );
  }
}
