part of 'product_by_category_cubit.dart';

class ProductByCategoryState extends Equatable {
  final bool isLoading;
  final List<ProductEntity> products;
  final String? error;

  const ProductByCategoryState({
    this.isLoading = true,
    this.products = const [],
    this.error,
  });

  ProductByCategoryState copyWith({
    bool? isLoading,
    List<ProductEntity>? products,
    String? error,
  }) {
    return ProductByCategoryState(
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, products, error];
}
