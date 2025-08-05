import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gadgetify/features/cart/domain/entity/cart_entity.dart';
import 'package:gadgetify/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:gadgetify/features/checkout/domain/entity/shipping_info_entity.dart';
import 'package:gadgetify/features/checkout/domain/use_case/create_order_use_case.dart';
import 'package:gadgetify/features/checkout/presentation/view_model/checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final CreateOrderUseCase _createOrderUseCase;
  final CartCubit _cartCubit;

  CheckoutCubit(this._createOrderUseCase, this._cartCubit)
    : super(const CheckoutState());

  // This method will now directly create the order
  Future<void> placeOrder({
    required List<CartItemEntity> cartItems,
    required ShippingInfoEntity shippingInfo,
  }) async {
    emit(state.copyWith(isLoading: true, error: null, isOrderPlaced: false));

    final params = CreateOrderParams(
      cartItems: cartItems,
      shippingInfo: shippingInfo,
    );
    final result = await _createOrderUseCase(params);

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure.error)),
      (_) {
        _cartCubit.clearCart(); // Clear the cart after a successful order
        emit(state.copyWith(isLoading: false, isOrderPlaced: true));
      },
    );
  }
}
