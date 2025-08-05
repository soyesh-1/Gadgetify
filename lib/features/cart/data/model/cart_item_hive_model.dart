import 'package:equatable/equatable.dart';
import 'package:gadgetify/app/constant/hive_table_constant.dart';
import 'package:gadgetify/features/cart/domain/entity/cart_entity.dart';
import 'package:hive/hive.dart';

part 'cart_item_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.cartTableId)
class CartItemHiveModel extends Equatable {
  @HiveField(0)
  final String productId;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String? image;
  @HiveField(3)
  final double price; 
  @HiveField(4)
  final int quantity;

  const CartItemHiveModel({
    required this.productId,
    required this.name,
    this.image,
    required this.price,
    required this.quantity,
  });

  CartItemEntity toEntity() => CartItemEntity(
    productId: productId,
    name: name,
    image: image,
    price: price,
    quantity: quantity,
  );

  factory CartItemHiveModel.fromEntity(CartItemEntity entity) =>
      CartItemHiveModel(
        productId: entity.productId,
        name: entity.name,
        image: entity.image,
        price: entity.price,
        quantity: entity.quantity,
      );

  @override
  List<Object?> get props => [productId, name, image, price, quantity];
}
