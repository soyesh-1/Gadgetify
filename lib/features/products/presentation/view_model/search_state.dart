import 'package:equatable/equatable.dart';
import 'package:gadgetify/features/products/domain/entity/product_entity.dart';

class SearchState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<ProductEntity> searchResults;

  const SearchState({
    this.isLoading = false,
    this.error,
    this.searchResults = const [],
  });

  SearchState copyWith({
    bool? isLoading,
    String? error,
    List<ProductEntity>? searchResults,
  }) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      searchResults: searchResults ?? this.searchResults,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, searchResults];
}
