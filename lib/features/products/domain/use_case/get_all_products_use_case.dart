import 'package:dartz/dartz.dart';
import 'package:gadgetify/core/error/failure.dart';
import 'package:gadgetify/features/products/domain/entity/product_entity.dart';
import 'package:gadgetify/features/products/domain/repository/product_repository.dart';

class GetAllProductsUseCase {
  final IProductRepository _productRepository;

  GetAllProductsUseCase(this._productRepository);

  Future<Either<Failure, List<ProductEntity>>> call() async {
    return await _productRepository.getAllProducts();
  }
}
