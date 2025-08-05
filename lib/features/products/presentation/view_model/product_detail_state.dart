import 'package:equatable/equatable.dart';
import 'package:gadgetify/features/products/domain/entity/product_entity.dart';

class ProductDetailState extends Equatable {
  final bool isLoading;
  final String? error;
  final ProductEntity? product;

  const ProductDetailState({this.isLoading = false, this.error, this.product});

  ProductDetailState copyWith({
    bool? isLoading,
    String? error,
    ProductEntity? product,
  }) {
    return ProductDetailState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      product: product ?? this.product,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, product];
}
