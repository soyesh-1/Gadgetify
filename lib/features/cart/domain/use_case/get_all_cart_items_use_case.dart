import 'package:gadgetify/app/use_case/use_case.dart';
import 'package:gadgetify/core/utils/typedef.dart';
import 'package:gadgetify/features/cart/domain/entity/cart_entity.dart';
import 'package:gadgetify/features/cart/domain/repository/cart_repository.dart';

class GetAllCartItemsUseCase extends UseCase<List<CartItemEntity>, NoParams> {
  final ICartRepository _repository;

  GetAllCartItemsUseCase(this._repository);

  @override
  DataState<List<CartItemEntity>> call(NoParams params) async {
    return await _repository.getAllCartItems();
  }
}
