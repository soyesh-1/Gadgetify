import 'package:gadgetify/app/use_case/use_case.dart';
import 'package:gadgetify/core/utils/typedef.dart';
import 'package:gadgetify/features/wishlist/domain/entity/wishlist_item_entity.dart';
import 'package:gadgetify/features/wishlist/domain/repository/wishlist_repository.dart';

class AddToWishlistUseCase extends UseCase<void, WishlistItemEntity> {
  final IWishlistRepository _repository;

  AddToWishlistUseCase(this._repository);

  @override
  DataState<void> call(WishlistItemEntity params) async {
    return await _repository.addToWishlist(params);
  }
}
