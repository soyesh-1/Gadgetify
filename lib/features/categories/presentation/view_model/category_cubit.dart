import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gadgetify/app/use_case/use_case.dart';
import 'package:gadgetify/features/categories/domain/use_case/get_all_categories_use_case.dart';
import 'package:gadgetify/features/categories/presentation/view_model/category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final GetAllCategoriesUseCase _getAllCategoriesUseCase;

  CategoryCubit(this._getAllCategoriesUseCase) : super(const CategoryState());

  Future<void> getAllCategories() async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllCategoriesUseCase(NoParams());
    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, error: failure.error));
      },
      (categories) {
        emit(state.copyWith(isLoading: false, categories: categories));
      },
    );
  }
}
