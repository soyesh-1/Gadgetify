import 'package:equatable/equatable.dart';
import 'package:gadgetify/features/home/domain/entity/category_entity.dart';
import 'package:gadgetify/features/products/domain/entity/product_entity.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final bool isLoading;
  final String? error;
  final List<ProductEntity> products;
  final List<CategoryEntity> categories; // ✅ ADDED

  const HomeState({
    this.selectedIndex = 0,
    this.isLoading = false,
    this.error,
    this.products = const [],
    this.categories = const [], // ✅ ADDED
  });

  HomeState copyWith({
    int? selectedIndex,
    bool? isLoading,
    String? error,
    List<ProductEntity>? products,
    List<CategoryEntity>? categories, // ✅ ADDED
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      products: products ?? this.products,
      categories: categories ?? this.categories, // ✅ ADDED
    );
  }

  @override
  // ✅ ADDED categories to props
  List<Object?> get props => [
    selectedIndex,
    isLoading,
    error,
    products,
    categories,
  ];
}
