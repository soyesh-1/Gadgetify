import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gadgetify/features/products/domain/use_case/get_product_by_id_use_case.dart';
import 'package:gadgetify/features/products/presentation/view_model/product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final GetProductByIdUseCase _getProductByIdUseCase;
  ProductDetailCubit(this._getProductByIdUseCase)
    : super(const ProductDetailState());

  Future<void> getProductById(String id) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await _getProductByIdUseCase(id);

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure.error)),
      (product) => emit(state.copyWith(isLoading: false, product: product)),
    );
  }
}
