import 'package:dartz/dartz.dart';
import 'package:gadgetify/core/error/exceptions.dart';
import 'package:gadgetify/core/error/failure.dart';
import 'package:gadgetify/core/utils/typedef.dart';
import 'package:gadgetify/features/products/data/data_source/remote_datasource/product_remote_data_source.dart';
import 'package:gadgetify/features/products/domain/entity/product_entity.dart';
import 'package:gadgetify/features/products/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements IProductRepository {
  final ProductRemoteDataSource _remoteDataSource;

  ProductRepositoryImpl(this._remoteDataSource);

  @override
  DataState<List<ProductEntity>> getAllProducts() async {
    try {
      final productModels = await _remoteDataSource.getAllProducts();
      // Assuming your ProductModel has a toEntity() method
      final List<ProductEntity> productEntities =
          productModels.map((model) => model.toEntity()).toList();
      return Right(productEntities);
    } on ServerException catch (e) {
      return Left(Failure(error: e.message));
    }
  }

  @override
  DataState<ProductEntity> getProductById(String id) async {
    try {
      final productModel = await _remoteDataSource.getProductById(id);
      // Assuming your ProductModel has a toEntity() method
      return Right(productModel.toEntity());
    } on ServerException catch (e) {
      return Left(Failure(error: e.message));
    }
  }

  @override
  DataState<List<ProductEntity>> getProductsByCategory(
    String categoryName,
  ) async {
    try {
      final productModels = await _remoteDataSource.getProductsByCategory(
        categoryName,
      );
      // Assuming your ProductModel has a toEntity() method
      final List<ProductEntity> productEntities =
          productModels.map((model) => model.toEntity()).toList();
      return Right(productEntities);
    } on ServerException catch (e) {
      return Left(Failure(error: e.message));
    }
  }

  // --- ADDED: Implementation for searching products ---
  @override
  DataState<List<ProductEntity>> searchProducts(String query) async {
    try {
      final productModels = await _remoteDataSource.searchProducts(query);
      final List<ProductEntity> productEntities =
          productModels.map((model) => model.toEntity()).toList();
      return Right(productEntities);
    } on ServerException catch (e) {
      return Left(Failure(error: e.message));
    }
  }
}
