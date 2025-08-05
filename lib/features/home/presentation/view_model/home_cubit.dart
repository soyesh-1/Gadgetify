import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gadgetify/features/home/domain/entity/category_entity.dart';
import 'package:gadgetify/features/home/presentation/view_model/home_state.dart';
import 'package:gadgetify/features/products/domain/use_case/get_all_products_use_case.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetAllProductsUseCase _getAllProductsUseCase;

  HomeCubit(this._getAllProductsUseCase) : super(const HomeState());

  void changeTab(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void getAllData() {
    getAllProducts();
    getCategories();
  }

  Future<void> getAllProducts() async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllProductsUseCase();

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, error: failure.error));
      },
      (products) {
        emit(state.copyWith(isLoading: false, products: products));
      },
    );
  }

  void getCategories() {
    final List<CategoryEntity> categories = [
      const CategoryEntity(
        id: '1',
        name: 'Mobiles',
        icon: CupertinoIcons.device_phone_portrait,
      ),
      const CategoryEntity(
        id: '2',
        name: 'Laptops',
        icon: CupertinoIcons.device_laptop,
      ),
      const CategoryEntity(
        id: '3',
        name: 'Headphones',
        icon: CupertinoIcons.headphones,
      ),
      const CategoryEntity(
        id: '4',
        name: 'Gaming',
        icon: CupertinoIcons.game_controller,
      ),
      const CategoryEntity(
        id: '5',
        name: 'Accessories',
        icon: CupertinoIcons.battery_25_percent,
      ),
    ];
    emit(state.copyWith(categories: categories));
  }
}
