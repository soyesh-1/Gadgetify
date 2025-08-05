import 'package:gadgetify/features/profile/domain/entity/order_item_entity.dart';

class OrderItemModel extends OrderItemEntity {
  const OrderItemModel({
    required super.name,
    required super.qty,
    required super.image,
    required super.price,
    required super.productId,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    String productId;
    // Check if the 'product' field is a String or a Map
    if (json['product'] is String) {
      productId = json['product'];
    } else if (json['product'] is Map) {
      productId = json['product']['_id'] as String? ?? '';
    } else {
      productId = '';
    }

    return OrderItemModel(
      name: json['name'] as String? ?? 'Unnamed Product',
      qty: json['qty'] as int? ?? 0,
      image: json['image'] as String? ?? '',
      price: (json['price'] as num? ?? 0).toDouble(),
      productId: productId,
    );
  }
}
