import 'package:equatable/equatable.dart';
import 'package:gadgetify/features/products/domain/entity/product_entity.dart';
import 'package:gadgetify/features/wishlist/domain/entity/wishlist_item_entity.dart';

class WishlistState extends Equatable {
  final bool isLoading;
  final List<WishlistItemEntity> items;
  final List<ProductEntity> products;
  final String? error;

  const WishlistState({
    this.isLoading = true,
    this.items = const [],
    this.products = const [],
    this.error,
  });

  WishlistState copyWith({
    bool? isLoading,
    List<WishlistItemEntity>? items,
    List<ProductEntity>? products,
    String? error,
  }) {
    return WishlistState(
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
      products: products ?? this.products,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, items, products, error];
}
