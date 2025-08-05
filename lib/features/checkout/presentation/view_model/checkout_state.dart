import 'package:equatable/equatable.dart';

class CheckoutState extends Equatable {
  final bool isLoading;
  final bool isOrderPlaced;
  final String? error;

  const CheckoutState({
    this.isLoading = false,
    this.isOrderPlaced = false,
    this.error,
  });

  CheckoutState copyWith({
    bool? isLoading,
    bool? isOrderPlaced,
    String? error,
  }) {
    return CheckoutState(
      isLoading: isLoading ?? this.isLoading,
      isOrderPlaced: isOrderPlaced ?? this.isOrderPlaced,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, isOrderPlaced, error];
}
