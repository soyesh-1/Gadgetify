import 'package:gadgetify/app/use_case/use_case.dart';
import 'package:gadgetify/core/utils/typedef.dart';
import 'package:gadgetify/features/cart/domain/entity/cart_entity.dart';
import 'package:gadgetify/features/cart/domain/repository/cart_repository.dart';

class AddCartItemUseCase extends UseCase<void, CartItemEntity> {
  final ICartRepository _repository;

  AddCartItemUseCase(this._repository);

  @override
  DataState<void> call(CartItemEntity params) async {
    return await _repository.addCartItem(params);
  }
}
