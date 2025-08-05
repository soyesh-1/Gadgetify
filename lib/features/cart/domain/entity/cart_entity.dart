import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable {
  final String productId;
  final String name;
  final String? image;
  final double price;
  final int quantity;

  const CartItemEntity({
    required this.productId,
    required this.name,
    this.image,
    required this.price,
    required this.quantity,
  });

  CartItemEntity copyWith({int? quantity}) {
    return CartItemEntity(
      productId: productId,
      name: name,
      image: image,
      price: price,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [productId, name, image, price, quantity];
}
