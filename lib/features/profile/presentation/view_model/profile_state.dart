// lib/features/profile/presentation/view_model/profile_state.dart

import 'package:equatable/equatable.dart';
// UPDATED import to use your AuthEntity
import 'package:gadgetify/features/auth/domain/entity/auth_entity.dart';
import 'package:gadgetify/features/profile/domain/entity/order_entity.dart';

class ProfileState extends Equatable {
  final bool isLoading;
  // UPDATED to use AuthEntity
  final AuthEntity? user;
  final List<OrderEntity> orders;
  final String? error;

  const ProfileState({
    this.isLoading = true,
    this.user,
    this.orders = const [],
    this.error,
  });

  ProfileState copyWith({
    bool? isLoading,
    // UPDATED to use AuthEntity
    AuthEntity? user,
    List<OrderEntity>? orders,
    String? error,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      orders: orders ?? this.orders,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, user, orders, error];
}
