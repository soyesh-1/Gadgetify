import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:gadgetify/core/utils/typedef.dart';
import 'package:gadgetify/features/categories/domain/entity/category_entity.dart';
import 'package:gadgetify/features/categories/domain/repository/category_repository.dart';

class CategoryRepositoryImpl implements ICategoryRepository {
  @override
  DataState<List<CategoryEntity>> getAllCategories() async {
    // This is where you would make an API call in a real app.
    // For now, we return a hardcoded list.
    final List<CategoryEntity> categories = [
      const CategoryEntity(
        id: '1',
        name: 'Phones',
        icon: CupertinoIcons.device_phone_portrait,
      ),
      const CategoryEntity(
        id: '2',
        name: 'Laptops',
        icon: CupertinoIcons.device_laptop,
      ),
      const CategoryEntity(
        id: '3',
        name: 'Audio',
        icon: CupertinoIcons.headphones,
      ),
      const CategoryEntity(
        id: '4',
        name: 'Gaming',
        icon: CupertinoIcons.game_controller,
      ),
      const CategoryEntity(
        id: '5',
        name: 'Cameras',
        icon: CupertinoIcons.camera,
      ),
    ];
    return Right(categories);
  }
}
