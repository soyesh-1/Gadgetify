import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gadgetify/app/constant/hive_table_constant.dart';
import 'package:gadgetify/app/use_case/use_case.dart';
import 'package:gadgetify/features/cart/data/model/cart_item_hive_model.dart';
import 'package:gadgetify/features/cart/domain/entity/cart_entity.dart';
import 'package:gadgetify/features/cart/domain/use_case/add_cart_item_use_case.dart';
import 'package:gadgetify/features/cart/domain/use_case/get_all_cart_items_use_case.dart';
import 'package:gadgetify/features/cart/domain/use_case/remove_cart_item_use_case.dart';
import 'package:gadgetify/features/products/domain/entity/product_entity.dart';
import 'package:gadgetify/features/cart/presentation/view_model/cart_state.dart';
import 'package:hive/hive.dart';

class CartCubit extends Cubit<CartState> {
  final GetAllCartItemsUseCase _getAllCartItemsUseCase;
  final AddCartItemUseCase _addCartItemUseCase;
  final RemoveCartItemUseCase _removeCartItemUseCase;

  CartCubit({
    required GetAllCartItemsUseCase getAllCartItemsUseCase,
    required AddCartItemUseCase addCartItemUseCase,
    required RemoveCartItemUseCase removeCartItemUseCase,
  }) : _getAllCartItemsUseCase = getAllCartItemsUseCase,
       _addCartItemUseCase = addCartItemUseCase,
       _removeCartItemUseCase = removeCartItemUseCase,
       super(const CartState());

  Future<void> getCartItems() async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllCartItemsUseCase(NoParams());
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure.error)),
      (items) => emit(state.copyWith(isLoading: false, cartItems: items)),
    );
  }

  Future<void> addToCart(ProductEntity product) async {
    final existingItemIndex = state.cartItems.indexWhere(
      (item) => item.productId == product.id,
    );

    int newQuantity = 1;
    if (existingItemIndex != -1) {
      newQuantity = state.cartItems[existingItemIndex].quantity + 1;
    }

    final cartItem = CartItemEntity(
      productId: product.id!,
      name: product.name,
      image: product.image,
      price: product.price.toDouble(),
      quantity: newQuantity,
    );

    final result = await _addCartItemUseCase(cartItem);
    result.fold(
      (failure) => emit(state.copyWith(error: failure.error)),
      (_) => getCartItems(),
    );
  }

  Future<void> removeFromCart(String productId) async {
    await _removeCartItemUseCase(productId);
    getCartItems();
  }

  Future<void> increaseQuantity(CartItemEntity item) async {
    final updatedItem = item.copyWith(quantity: item.quantity + 1);
    await _addCartItemUseCase(updatedItem);
    getCartItems();
  }

  Future<void> decreaseQuantity(CartItemEntity item) async {
    if (item.quantity > 1) {
      final updatedItem = item.copyWith(quantity: item.quantity - 1);
      await _addCartItemUseCase(updatedItem);
      getCartItems();
    } else {
      removeFromCart(item.productId);
    }
  }

  Future<void> clearCart() async {
    final box = await Hive.openBox<CartItemHiveModel>(
      HiveTableConstant.cartBox,
    );
    await box.clear();
    getCartItems();
  }
}
