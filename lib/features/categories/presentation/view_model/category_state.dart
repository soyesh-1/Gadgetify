import 'package:equatable/equatable.dart';
import 'package:gadgetify/features/categories/domain/entity/category_entity.dart';

class CategoryState extends Equatable {
  final bool isLoading;
  final List<CategoryEntity> categories;
  final String? error;

  const CategoryState({
    this.isLoading = true,
    this.categories = const [],
    this.error,
  });

  CategoryState copyWith({
    bool? isLoading,
    List<CategoryEntity>? categories,
    String? error,
  }) {
    return CategoryState(
      isLoading: isLoading ?? this.isLoading,
      categories: categories ?? this.categories,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, categories, error];
}
