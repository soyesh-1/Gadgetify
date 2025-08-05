import 'package:gadgetify/app/use_case/use_case.dart';
import 'package:gadgetify/core/utils/typedef.dart';
import 'package:gadgetify/features/products/domain/entity/product_entity.dart';
import 'package:gadgetify/features/products/domain/repository/product_repository.dart';

class GetProductsByCategoryUseCase
    extends UseCase<List<ProductEntity>, String> {
  final IProductRepository _repository;

  GetProductsByCategoryUseCase(this._repository);

  @override
  DataState<List<ProductEntity>> call(String categoryName) async {
    return await _repository.getProductsByCategory(categoryName);
  }
}
