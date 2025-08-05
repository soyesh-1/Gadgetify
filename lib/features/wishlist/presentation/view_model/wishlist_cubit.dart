import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gadgetify/app/use_case/use_case.dart';
import 'package:gadgetify/features/wishlist/domain/entity/wishlist_item_entity.dart';
import 'package:gadgetify/features/wishlist/domain/use_case/add_to_wishlist_use_case.dart';
import 'package:gadgetify/features/wishlist/domain/use_case/get_all_wishlist_items_use_case.dart';
import 'package:gadgetify/features/wishlist/domain/use_case/get_wishlist_products_use_case.dart';
import 'package:gadgetify/features/wishlist/domain/use_case/remove_from_wishlist_use_case.dart';
import 'package:gadgetify/features/wishlist/presentation/view_model/wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final AddToWishlistUseCase _addToWishlistUseCase;
  final RemoveFromWishlistUseCase _removeFromWishlistUseCase;
  final GetAllWishlistItemsUseCase _getAllWishlistItemsUseCase;
  // ✅ 1. ADD THE NEW USE CASE
  final GetWishlistProductsUseCase _getWishlistProductsUseCase;

  WishlistCubit({
    required AddToWishlistUseCase addToWishlistUseCase,
    required RemoveFromWishlistUseCase removeFromWishlistUseCase,
    required GetAllWishlistItemsUseCase getAllWishlistItemsUseCase,
    // ✅ 2. INJECT THE NEW USE CASE
    required GetWishlistProductsUseCase getWishlistProductsUseCase,
  }) : _addToWishlistUseCase = addToWishlistUseCase,
       _removeFromWishlistUseCase = removeFromWishlistUseCase,
       _getAllWishlistItemsUseCase = getAllWishlistItemsUseCase,
       _getWishlistProductsUseCase = getWishlistProductsUseCase,
       super(const WishlistState());

  // ✅ 3. UPDATE THIS METHOD TO FETCH FULL PRODUCTS
  Future<void> getWishlistItems() async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllWishlistItemsUseCase(NoParams());
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure.error)),
      (items) {
        // After getting the wishlist item IDs, fetch their full product details
        final productIds = items.map((item) => item.productId).toList();
        _getWishlistProducts(productIds);
        // Also update the state with the latest item IDs
        emit(state.copyWith(isLoading: false, items: items));
      },
    );
  }

  // ✅ 4. ADD THIS NEW PRIVATE METHOD
  Future<void> _getWishlistProducts(List<String> productIds) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getWishlistProductsUseCase(productIds);
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure.error)),
      (products) => emit(state.copyWith(isLoading: false, products: products)),
    );
  }

  Future<void> addToWishlist(String productId) async {
    final entity = WishlistItemEntity(productId: productId);
    final result = await _addToWishlistUseCase(entity);
    result.fold(
      (failure) => emit(state.copyWith(error: failure.error)),
      (_) => getWishlistItems(), // Refresh the list
    );
  }

  Future<void> removeFromWishlist(String productId) async {
    final result = await _removeFromWishlistUseCase(productId);
    result.fold(
      (failure) => emit(state.copyWith(error: failure.error)),
      (_) => getWishlistItems(), // Refresh the list
    );
  }

  bool isFavorite(String productId) {
    return state.items.any((item) => item.productId == productId);
  }
}
