import 'package:gadgetify/app/use_case/use_case.dart';
import 'package:gadgetify/core/utils/typedef.dart';
import 'package:gadgetify/features/wishlist/domain/entity/wishlist_item_entity.dart';
import 'package:gadgetify/features/wishlist/domain/repository/wishlist_repository.dart';

class GetAllWishlistItemsUseCase
    extends UseCase<List<WishlistItemEntity>, NoParams> {
  final IWishlistRepository _repository;

  GetAllWishlistItemsUseCase(this._repository);

  @override
  DataState<List<WishlistItemEntity>> call(NoParams params) async {
    return await _repository.getAllWishlistItems();
  }
}
