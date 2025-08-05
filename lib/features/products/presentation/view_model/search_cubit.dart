import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gadgetify/features/products/domain/use_case/search_products_use_case.dart';
import 'package:gadgetify/features/products/presentation/view_model/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchProductsUseCase _searchProductsUseCase;

  SearchCubit(this._searchProductsUseCase) : super(const SearchState());

  Future<void> performSearch(String query) async {
    if (query.isEmpty) {
      emit(state.copyWith(searchResults: [], error: null));
      return;
    }
    emit(state.copyWith(isLoading: true, error: null));
    final result = await _searchProductsUseCase(query);

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure.error)),
      (products) =>
          emit(state.copyWith(isLoading: false, searchResults: products)),
    );
  }
}
