import 'package:gadgetify/app/use_case/use_case.dart';
import 'package:gadgetify/core/utils/typedef.dart';
import 'package:gadgetify/features/cart/domain/entity/cart_entity.dart';
import 'package:gadgetify/features/checkout/domain/entity/shipping_info_entity.dart';
import 'package:gadgetify/features/checkout/domain/repository/checkout_repository.dart';

class CreateOrderUseCase extends UseCase<void, CreateOrderParams> {
  final ICheckoutRepository _repository;

  CreateOrderUseCase(this._repository);

  @override
  DataState<void> call(CreateOrderParams params) async {
    return await _repository.createOrder(params.cartItems, params.shippingInfo);
  }
}

// This is a simple helper class to group the parameters for the use case
class CreateOrderParams {
  final List<CartItemEntity> cartItems;
  final ShippingInfoEntity shippingInfo;

  CreateOrderParams({required this.cartItems, required this.shippingInfo});
}
