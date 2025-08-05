import 'package:gadgetify/app/use_case/use_case.dart';
import 'package:gadgetify/core/utils/typedef.dart';
import 'package:gadgetify/features/categories/domain/entity/category_entity.dart';
import 'package:gadgetify/features/categories/domain/repository/category_repository.dart';

class GetAllCategoriesUseCase extends UseCase<List<CategoryEntity>, NoParams> {
  final ICategoryRepository _repository;

  GetAllCategoriesUseCase(this._repository);

  @override
  DataState<List<CategoryEntity>> call(NoParams params) async {
    return await _repository.getAllCategories();
  }
}
