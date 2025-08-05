import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gadgetify/features/products/domain/entity/product_entity.dart';
import 'package:gadgetify/features/products/domain/use_case/get_products_by_category_use_case.dart';
import 'package:equatable/equatable.dart';

part 'product_by_category_state.dart';

class ProductByCategoryCubit extends Cubit<ProductByCategoryState> {
  final GetProductsByCategoryUseCase _useCase;

  ProductByCategoryCubit(this._useCase) : super(ProductByCategoryState());

  Future<void> getProducts(String categoryName) async {
    emit(state.copyWith(isLoading: true));
    final result = await _useCase(categoryName);
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure.error)),
      (products) => emit(state.copyWith(isLoading: false, products: products)),
    );
  }
}
