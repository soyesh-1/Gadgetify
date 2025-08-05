import 'package:gadgetify/app/use_case/use_case.dart';
import 'package:gadgetify/core/utils/typedef.dart';
import 'package:gadgetify/features/wishlist/domain/repository/wishlist_repository.dart';

class RemoveFromWishlistUseCase extends UseCase<void, String> {
  final IWishlistRepository _repository;

  RemoveFromWishlistUseCase(this._repository);

  @override
  DataState<void> call(String params) async {
    return await _repository.removeFromWishlist(params);
  }
}
