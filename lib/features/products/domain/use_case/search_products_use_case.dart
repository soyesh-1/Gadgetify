// lib/features/products/domain/use_case/search_products_use_case.dart
import 'package:gadgetify/app/use_case/use_case.dart';
import 'package:gadgetify/core/utils/typedef.dart';
import 'package:gadgetify/features/products/domain/entity/product_entity.dart';
import 'package:gadgetify/features/products/domain/repository/product_repository.dart';

class SearchProductsUseCase extends UseCase<List<ProductEntity>, String> {
  final IProductRepository _repository;

  SearchProductsUseCase(this._repository);

  @override
  DataState<List<ProductEntity>> call(String query) async {
    return await _repository.searchProducts(query);
  }
}
