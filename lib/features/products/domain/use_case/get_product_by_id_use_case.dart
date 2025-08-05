import 'package:dartz/dartz.dart';
import 'package:gadgetify/core/error/failure.dart';
import 'package:gadgetify/features/products/domain/entity/product_entity.dart';
import 'package:gadgetify/features/products/domain/repository/product_repository.dart';

class GetProductByIdUseCase {
  final IProductRepository _productRepository;
  GetProductByIdUseCase(this._productRepository);

  Future<Either<Failure, ProductEntity>> call(String id) async {
    return await _productRepository.getProductById(id);
  }
}
