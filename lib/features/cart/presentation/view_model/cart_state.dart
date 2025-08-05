import 'package:equatable/equatable.dart';
import 'package:gadgetify/features/cart/domain/entity/cart_entity.dart';

class CartState extends Equatable {
  final bool isLoading;
  final List<CartItemEntity> cartItems;
  final String? error;

  double get totalPrice =>
      cartItems.fold(0, (total, item) => total + (item.price * item.quantity));

  const CartState({
    this.isLoading = false,
    this.cartItems = const [],
    this.error,
  });

  CartState copyWith({
    bool? isLoading,
    List<CartItemEntity>? cartItems,
    String? error,
  }) {
    return CartState(
      isLoading: isLoading ?? this.isLoading,
      cartItems: cartItems ?? this.cartItems,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, cartItems, error];
}
