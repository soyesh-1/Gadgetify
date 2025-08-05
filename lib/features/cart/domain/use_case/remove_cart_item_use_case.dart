import 'package:gadgetify/app/use_case/use_case.dart';
import 'package:gadgetify/core/utils/typedef.dart';
import 'package:gadgetify/features/cart/domain/repository/cart_repository.dart';

class RemoveCartItemUseCase extends UseCase<void, String> {
  final ICartRepository _repository;

  RemoveCartItemUseCase(this._repository);

  @override
  DataState<void> call(String params) async {
    return await _repository.removeCartItem(params);
  }
}
