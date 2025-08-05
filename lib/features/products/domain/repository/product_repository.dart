import 'package:dartz/dartz.dart';
import 'package:gadgetify/core/error/failure.dart';
import 'package:gadgetify/core/utils/typedef.dart';
import 'package:gadgetify/features/products/domain/entity/product_entity.dart';

abstract class IProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getAllProducts();
  Future<Either<Failure, ProductEntity>> getProductById(String id);
  DataState<List<ProductEntity>> getProductsByCategory(String categoryName);
  DataState<List<ProductEntity>> searchProducts(String query);
}
