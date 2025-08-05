import 'package:dartz/dartz.dart';
import 'package:gadgetify/app/use_case/use_case.dart';
import 'package:gadgetify/core/utils/typedef.dart';
import 'package:gadgetify/features/products/domain/entity/product_entity.dart';
import 'package:gadgetify/features/products/domain/repository/product_repository.dart';

class GetWishlistProductsUseCase
    extends UseCase<List<ProductEntity>, List<String>> {
  final IProductRepository _productRepository;

  GetWishlistProductsUseCase(this._productRepository);

  @override
  DataState<List<ProductEntity>> call(List<String> productIds) async {
    // This is a simplified approach. In a real-world scenario, you might
    // create a specific endpoint to fetch multiple products by ID.
    // For now, we fetch them one by one.
    List<ProductEntity> products = [];
    for (String id in productIds) {
      final result = await _productRepository.getProductById(id);
      result.fold(
        (l) => null, // Ignore failures for now
        (product) => products.add(product),
      );
    }
    return Right(products);
  }
}
