// lib/features/profile/domain/entity/order_item_entity.dart

import 'package:equatable/equatable.dart';

class OrderItemEntity extends Equatable {
  final String name;
  final int qty;
  final String image;
  final double price;
  final String productId;

  const OrderItemEntity({
    required this.name,
    required this.qty,
    required this.image,
    required this.price,
    required this.productId,
  });

  @override
  List<Object?> get props => [name, qty, image, price, productId];
}
