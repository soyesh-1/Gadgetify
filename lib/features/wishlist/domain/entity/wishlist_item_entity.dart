import 'package:equatable/equatable.dart';

class WishlistItemEntity extends Equatable {
  final String productId;

  const WishlistItemEntity({required this.productId});

  @override
  List<Object?> get props => [productId];
}
