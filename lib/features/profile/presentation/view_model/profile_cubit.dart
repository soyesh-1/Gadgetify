// lib/features/profile/presentation/view_model/profile_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gadgetify/app/use_case/use_case.dart';
import 'package:gadgetify/features/auth/data/data_source/local_datasource/auth_local_data_source.dart';
import 'package:gadgetify/features/auth/domain/entity/auth_entity.dart';
import 'package:gadgetify/features/profile/domain/use_case/get_my_orders_usecase.dart';
import 'package:gadgetify/features/profile/presentation/view_model/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetMyOrdersUseCase _getMyOrdersUseCase;
  final AuthLocalDataSource _authLocalDataSource;

  ProfileCubit({
    required GetMyOrdersUseCase getMyOrdersUseCase,
    required AuthLocalDataSource authLocalDataSource,
  }) : _getMyOrdersUseCase = getMyOrdersUseCase,
       _authLocalDataSource = authLocalDataSource,
       super(const ProfileState());

  Future<void> fetchProfileData() async {
    print("--- 1. Starting to fetch profile data ---");
    emit(state.copyWith(isLoading: true, error: null));

    // Fetch User Info from local Hive box first
    final userResult = await _authLocalDataSource.getUser();
    AuthEntity? user;
    userResult.fold(
      (failure) => emit(state.copyWith(error: failure.error)),
      (userData) => user = userData,
    );

    // Fetch Orders from the API
    print("--- 2. Calling GetMyOrdersUseCase (API call) ---");
    final ordersResult = await _getMyOrdersUseCase(NoParams());
    print("--- 3. GetMyOrdersUseCase FINISHED ---"); // <-- CHECK IF THIS PRINTS

    ordersResult.fold(
      (failure) {
        print("--- 4a. Orders failed: ${failure.error} ---");
        emit(
          state.copyWith(isLoading: false, error: failure.error, user: user),
        );
      },
      (orders) {
        print("--- 4b. Orders success: ${orders.length} orders found ---");
        emit(
          state.copyWith(
            isLoading: false,
            user: user,
            orders: orders,
            error: null,
          ),
        );
      },
    );
  }
}
