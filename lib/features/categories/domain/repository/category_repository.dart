import 'package:gadgetify/core/utils/typedef.dart';
import 'package:gadgetify/features/categories/domain/entity/category_entity.dart';

abstract class ICategoryRepository {
  DataState<List<CategoryEntity>> getAllCategories();
}
