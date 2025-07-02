import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:gadgetify/core/network/network_info.dart';
import 'package:gadgetify/features/auth/data/data_source/local_datasource/auth_local_data_source.dart';
import 'package:gadgetify/features/auth/data/data_source/remote_datasource/auth_remote_data_source.dart';
import 'package:gadgetify/features/auth/data/repository/auth_repository_impl.dart';
import 'package:gadgetify/features/auth/domain/repository/auth_repository.dart';
import 'package:gadgetify/features/auth/domain/use_case/login_use_case.dart';
import 'package:gadgetify/features/auth/domain/use_case/signup_use_case.dart';
import 'package:gadgetify/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:gadgetify/features/home/presentation/view_model/home_cubit.dart';
import 'package:gadgetify/features/splash/presentation/view_model/splash_cubit.dart';

final sl = GetIt.instance;

void setupDependencies() {
  // Core
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<INetworkInfo>(() => NetworkInfo(sl<Connectivity>()));

  // Auth Feature
  sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSource());
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(sl<Dio>()),
  );
  sl.registerLazySingleton<IAuthRepository>(
    () => AuthRepositoryImpl(
      sl<AuthLocalDataSource>(),
      sl<AuthRemoteDataSource>(),
      sl<INetworkInfo>(),
    ),
  );
  sl.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(sl<IAuthRepository>()),
  );
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl<IAuthRepository>()),
  );
  sl.registerFactory<AuthCubit>(
    () => AuthCubit(
      signUpUseCase: sl<SignUpUseCase>(),
      loginUseCase: sl<LoginUseCase>(),
    ),
  );

  // Home Feature
  sl.registerFactory<HomeCubit>(() => HomeCubit());

  // Splash Feature
  sl.registerFactory<SplashCubit>(() => SplashCubit());
}
